import {
  BadRequestException,
  Inject,
  Injectable,
  LoggerService,
  NotFoundException,
  OnModuleInit,
} from '@nestjs/common';
import { InjectQueue } from '@nestjs/bull';
import { Queue } from 'bull';
import { InjectRepository } from '@nestjs/typeorm';
import { TaskEntity } from './task.entity';
import { Like, Repository } from 'typeorm';
import {
  SYS_TASK_QUEUE_NAME,
  SYS_TASK_QUEUE_PREFIX,
  TaskStatus,
  TaskType,
} from './constant';
import { InjectRedis } from '~/common/decorators/inject-redis.decorator';
import Redis from 'ioredis';
import { isEmpty, isNil } from 'lodash';
import { TaskCreateDto, TaskQueryDto, TaskUpdateDto } from './task.dto';
import { Pagination } from '~/helper/pagination/pagination';
import { paginate } from '~/helper/pagination';
import { ModuleRef, Reflector } from '@nestjs/core';
import { MISSION_DECORATOR_KEY } from '~/modules/tasks/mission.decorator';
import { BusinessException } from '~/common/exceptions/biz.exception';
import { ErrorEnum } from '~/constants/error.constant';
import { WINSTON_MODULE_NEST_PROVIDER } from 'nest-winston';

@Injectable()
export class TaskService implements OnModuleInit {
  constructor(
    @InjectRepository(TaskEntity)
    private readonly taskRepository: Repository<TaskEntity>,
    @InjectRedis() readonly redis: Redis,
    @InjectQueue(SYS_TASK_QUEUE_NAME) private taskQueue: Queue,
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: LoggerService,
    private readonly moduleRef: ModuleRef,
    private readonly reflector: Reflector,
  ) {}

  /**
   * model init
   */
  async onModuleInit() {
    await this.initTask();
  }

  /**
   * init task
   */
  async initTask(): Promise<void> {
    const initKey = `${SYS_TASK_QUEUE_PREFIX}:init`;
    const result = await this.redis
      .multi()
      .setnx(initKey, new Date().getTime())
      .expire(initKey, 60 * 30)
      .exec();

    // 如果已经有了，则不执行了 0 表示已经有了 1 表示没有
    if (result[0][1] === 0) {
      this.logger.log('[Task]', 'init task is lock' + TaskService.name);
      return;
    }

    const jobs = await this.taskQueue.getJobs([
      'active',
      'delayed',
      'failed',
      'paused',
      'waiting',
      'completed',
    ]);
    !isEmpty(jobs) &&
      jobs.forEach(async (job) => {
        await job.remove();
      });

    // 查找所有需要运行的项目
    const tasks = await this.taskRepository.findBy({
      status: 1,
    });

    if (!isEmpty(tasks)) {
      for (const task of tasks) {
        await this.start(task.id);
      }
    }

    // 启动后释放锁
    await this.redis.del(initKey);
  }

  async list({
    pageSize,
    currentPage,
    name,
    service,
    type,
    status,
  }: TaskQueryDto): Promise<Pagination<TaskEntity>> {
    const queryBuilder = await this.taskRepository
      .createQueryBuilder('task')
      .where({
        ...(name && { name: Like(`%${name}%`) }),
        ...(service && { service: Like(`%${service}%`) }),
        ...(type && { type }),
        ...(!isNil(status) && { status }),
      })
      .orderBy({ 'task.createdAt': 'ASC' });

    return paginate(queryBuilder, { currentPage, pageSize });
  }

  async info(id: string): Promise<TaskEntity> {
    const task = await this.taskRepository.findOne({
      where: { id },
    });

    if (!task) throw new NotFoundException('任务不存在');

    return task;
  }

  async delete(id: string): Promise<void> {
    await this.info(id);
    await this.stop(id);
    await this.taskRepository.delete(id);
  }

  async once(id: string): Promise<void> {
    const task = await this.info(id);
    await this.taskQueue.add(
      {
        id: task.id,
        service: task.service,
        args: task.data,
      },
      {
        jobId: task.id,
        removeOnComplete: true,
        removeOnFail: true,
      },
    );
  }

  async create(dto: TaskCreateDto): Promise<void> {
    const result = await this.taskRepository.save(dto);
    const task = await this.info(result.id);
    if (result.status === 0) {
      await this.stop(task.id);
    } else {
      await this.start(task.id);
    }
  }

  async update(id: string, dto: TaskUpdateDto): Promise<void> {
    await this.taskRepository.update(id, dto);
    const task = await this.info(id);
    if (task.status === 0) {
      await this.stop(id);
    } else {
      await this.start(id);
    }
  }

  async start(id: string): Promise<void> {
    const task = await this.info(id);
    if (isEmpty(task)) throw new BadRequestException('任务不存在');

    await this.stop(id);
    let repeat: any;
    // repeat task
    if (task.type === TaskType.Interval) {
      repeat = {
        every: task.every,
      };
    } else {
      repeat = {
        cron: task.cron,
      };
      if (task.startTime) {
        repeat.startDate = task.startTime;
      }

      if (task.endTime) {
        repeat.endDate = task.endTime;
      }
    }

    if (task.limit > 0) repeat.limit = task.limit;

    const job = await this.taskQueue.add(
      {
        id: task.id,
        service: task.service,
        args: task.data,
      },
      {
        jobId: task.id,
        removeOnComplete: true,
        removeOnFail: true,
        repeat,
      },
    );

    if (job && job.opts) {
      await this.taskRepository.update(task.id, {
        jobOpts: JSON.stringify(job.opts.repeat),
        status: TaskStatus.Active,
      });
    } else {
      await job?.remove();
      await this.taskRepository.update(task.id, {
        status: TaskStatus.Disabled,
      });
      throw new BadRequestException('任务创建失败');
    }
  }

  async stop(id: string): Promise<void> {
    const task = await this.info(id);
    if (isEmpty(task)) throw new BadRequestException('任务不存在');

    const exist = await this.existJob(task.id);
    if (!exist) {
      await this.taskRepository.update(task.id, {
        status: TaskStatus.Disabled,
      });
      return;
    }

    const jobs = await this.taskQueue.getJobs([
      'active',
      'delayed',
      'failed',
      'paused',
      'waiting',
      'completed',
    ]);

    !isEmpty(jobs) &&
      jobs
        .filter((job) => job.data.id === task.id)
        .forEach(async (job) => {
          await job.remove();
        });

    // 删除队列中的任务
    await this.taskQueue.removeRepeatable(JSON.parse(task.jobOpts));

    await this.taskRepository.update(task.id, {
      status: TaskStatus.Disabled,
    });
  }

  /**
   * 查看队列中任务是否存在
   */
  async existJob(jobId: string): Promise<boolean> {
    // https://github.com/OptimalBits/bull/blob/develop/REFERENCE.md#queueremoverepeatablebykey
    const jobs = await this.taskQueue.getRepeatableJobs();
    const ids = jobs.map((e) => {
      return e.id;
    });
    return ids.includes(jobId);
  }

  /**
   * 更新是否已经完成 完成需要移除任务 并修改状态
   */
  async updateTaskCompleteStatus(tid: string): Promise<void> {
    const jobs = await this.taskQueue.getRepeatableJobs();
    const task = await this.taskRepository.findOneBy({ id: tid });

    for (const job of jobs) {
      const currentTIme = new Date().getTime();
      if (job.id === tid && job.next < currentTIme) {
        await this.stop(task.id);
        break;
      }
    }
  }

  /**
   * 检测service是否有注解定义
   */
  async checkHasMissionMeta(
    nameOrInstance: string | unknown,
    exec: string,
  ): Promise<void> {
    try {
      let service: any;
      if (typeof nameOrInstance === 'string') {
        service = await this.moduleRef.get(nameOrInstance, { strict: false });
      } else {
        service = nameOrInstance;
      }

      if (!service || !(exec in service)) {
        throw new NotFoundException('任务不存在');
      }

      const hasMission = this.reflector.get<boolean>(
        MISSION_DECORATOR_KEY,
        service.constructor,
      );

      if (!hasMission) {
        throw new BusinessException(ErrorEnum.TASK_INSECURE_MISSION);
      }
    } catch (e) {
      console.log(e);

      throw new NotFoundException('任务不存在');
    }
  }

  /**
   * 根据serviceName调用service，例如 LogService.clearReqLog
   * @param name
   * @param args
   */
  async callService(name: string, args: string): Promise<void> {
    if (!name) return;

    const [serviceName, methodName] = name.split('.');
    if (!serviceName) throw new BadRequestException('任务名不存在');

    const service = this.moduleRef.get(serviceName, { strict: false });

    await this.checkHasMissionMeta(service, methodName);

    if (isEmpty(args)) {
      await service[methodName]();
    } else {
      const parseArgs = this.safeParse(args);
      if (Array.isArray(parseArgs)) {
        await service[methodName](...parseArgs);
      } else {
        await service[methodName](parseArgs);
      }
    }
  }

  safeParse(args: string): unknown | string {
    try {
      return JSON.parse(args);
    } catch (e) {
      return args;
    }
  }
}
