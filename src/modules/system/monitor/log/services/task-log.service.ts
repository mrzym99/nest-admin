import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TaskLogEntity } from '../entities/task-log.entity';
import { LessThan, Like, Repository } from 'typeorm';
import { TaskLogQueryDto } from '../dto/log.dto';
import { paginate } from '~/helper/pagination';
import { isNil } from 'lodash';

@Injectable()
export class TaskLogService {
  constructor(
    @InjectRepository(TaskLogEntity)
    private readonly taskLogRepository: Repository<TaskLogEntity>,
  ) {}

  async create(
    tid: number,
    status: number,
    time?: number,
    err?: string,
  ): Promise<number> {
    const taskLog = await this.taskLogRepository.save({
      status,
      consumeTime: time,
      detail: err,
      task: {
        id: tid,
      },
    });

    return taskLog.id;
  }

  async list({ currentPage, pageSize, name, status }: TaskLogQueryDto) {
    const queryBuilder = await this.taskLogRepository
      .createQueryBuilder('task_log')
      .leftJoinAndSelect('task_log.task', 'task')
      .where({
        ...(name && {
          task: {
            name: Like(`%${name}%`),
          },
        }),
        ...(!isNil(status) && { status }),
      })
      .orderBy({ 'task_log.createdAt': 'DESC' });

    const { list, total } = await paginate<TaskLogEntity>(queryBuilder, {
      currentPage,
      pageSize,
    });

    const listDate = list.map((item) => {
      return {
        ...item,
        taskId: item.task.id,
        name: item.task.name,
      };
    });

    return {
      currentPage,
      pageSize,
      list: listDate,
      total,
    };
  }

  async deleteLogs(ids: number[]): Promise<void> {
    await this.taskLogRepository.delete(ids);
  }

  async clearLog() {
    await this.taskLogRepository.clear();
  }

  async clearLogBeforeTime(time: Date) {
    await this.taskLogRepository.delete({
      createdAt: LessThan(time),
    });
  }
}
