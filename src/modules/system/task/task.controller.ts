import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  Query,
} from '@nestjs/common';
import { TaskService } from './task.service';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { ApiResult } from '~/common/decorators/api-result.decorator';
import { TaskEntity } from './task.entity';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';
import { TaskCreateDto, TaskQueryDto, TaskUpdateDto } from './task.dto';
import { Pagination } from '~/helper/pagination/pagination';

export const permissions = definePermission('system:task', {
  LIST: 'list',
  CREATE: 'create',
  READ: 'read',
  UPDATE: 'update',
  DELETE: 'delete',

  ONCE: 'once',
  START: 'start',
  STOP: 'stop',
} as const);

@ApiTags('System - 任务调度模块')
@ApiSecurityAuth()
@Controller('task')
export class TaskController {
  constructor(private readonly taskService: TaskService) {}

  @Get('list')
  @ApiOperation({ summary: '获取任务列表' })
  @ApiResult({
    type: [TaskEntity],
    isPage: true,
  })
  @Perm(permissions.LIST)
  async list(@Query() dto: TaskQueryDto): Promise<Pagination<TaskEntity>> {
    return await this.taskService.list(dto);
  }

  @Post()
  @ApiOperation({ summary: '创建任务' })
  @Perm(permissions.CREATE)
  async create(@Body() dto: TaskCreateDto): Promise<void> {
    const serviceCall = dto.service.split('.');
    await this.taskService.checkHasMissionMeta(serviceCall[0], serviceCall[1]);
    await this.taskService.create(dto);
  }

  @Put(':id')
  @ApiOperation({ summary: '更新任务' })
  @Perm(permissions.UPDATE)
  async update(
    @Param('id') id: string,
    @Body() dto: TaskUpdateDto,
  ): Promise<void> {
    const serviceCall = dto.service.split('.');
    await this.taskService.checkHasMissionMeta(serviceCall[0], serviceCall[1]);
    await this.taskService.update(id, dto);
  }

  @Get('info/:id')
  @ApiOperation({ summary: '获取任务详情' })
  @ApiResult({ type: TaskEntity })
  @Perm(permissions.READ)
  async info(@Param('id') id: string): Promise<TaskEntity> {
    return await this.taskService.info(id);
  }

  @Delete(':id')
  @ApiOperation({ summary: '删除任务' })
  @Perm(permissions.DELETE)
  async delete(@Param('id') id: string): Promise<void> {
    await this.taskService.delete(id);
  }

  @Put(':id/once')
  @ApiOperation({ summary: '立即执行一次任务' })
  @Perm(permissions.ONCE)
  async once(@Param('id') id: string): Promise<void> {
    await this.taskService.once(id);
  }

  @Put(':id/stop')
  @ApiOperation({ summary: '停止任务' })
  @Perm(permissions.STOP)
  async stop(@Param('id') id: string): Promise<void> {
    await this.taskService.stop(id);
  }

  @Put(':id/start')
  @ApiOperation({ summary: '启动任务' })
  @Perm(permissions.START)
  async start(@Param('id') id: string): Promise<void> {
    await this.taskService.start(id);
  }
}
