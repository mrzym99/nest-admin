import { Body, Controller, Delete, Get, Query } from '@nestjs/common';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { LoginLogService } from './services/login-log.service';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { ApiResult } from '~/common/decorators/api-result.decorator';
import {
  CaptchaLogQueryDto,
  LoginLogQueryDto,
  TaskLogQueryDto,
} from './dto/log.dto';
import { Pagination } from '~/helper/pagination/pagination';
import { LoginLogInfo, TaskLogInfo } from './models/log.model';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';
import { TaskLogService } from './services/task-log.service';
import { CaptchaLogEntity } from './entities/captcha-log.entity';
import { TaskLogEntity } from './entities/task-log.entity';
import { CaptchaLogService } from './services/captcha-log.service';
import { DeleteDto } from '~/common/dto/delete.dto';

export const permissions = definePermission('system:log', {
  LOGINLIST: 'login:list',
  LOGINDELETE: 'login:delete',
  TASKLIST: 'task:list',
  TASKDELETE: 'task:delete',
  CAPTCHALIST: 'captcha:list',
  CAPTCHADELETE: 'captcha:delete',
} as const);

@ApiSecurityAuth()
@ApiTags('System - 日志模块')
@Controller('log')
export class LogController {
  constructor(
    private readonly loginLogService: LoginLogService,
    private readonly taskLogService: TaskLogService,
    private readonly captchaLogService: CaptchaLogService,
  ) {}

  @Get('login/list')
  @ApiOperation({ summary: '查询登录日志列表' })
  @ApiResult({ type: [LoginLogInfo], isPage: true })
  @Perm(permissions.LOGINLIST)
  async loginLogList(
    @Query() dto: LoginLogQueryDto,
  ): Promise<Pagination<LoginLogInfo>> {
    return await this.loginLogService.list(dto);
  }

  @Delete('login/delete')
  @ApiOperation({ summary: ' 批量删除登录日志' })
  @Perm(permissions.LOGINDELETE)
  async deleteLoginLog(@Body() dto: DeleteDto): Promise<void> {
    const { ids } = dto;
    await this.loginLogService.deleteLogs(ids);
  }

  @Get('task/list')
  @ApiOperation({ summary: '查询任务日志列表' })
  @ApiResult({ type: [TaskLogInfo], isPage: true })
  @Perm(permissions.TASKLIST)
  async taskLogList(
    @Query() dto: TaskLogQueryDto,
  ): Promise<Pagination<TaskLogInfo>> {
    return await this.taskLogService.list(dto);
  }

  @Delete('task/delete')
  @ApiOperation({ summary: ' 批量删除任务日志' })
  @Perm(permissions.TASKDELETE)
  async deleteTaskLog(@Body() dto: DeleteDto): Promise<void> {
    const { ids } = dto;
    await this.taskLogService.deleteLogs(ids);
  }

  @Get('captcha/list')
  @ApiOperation({ summary: '查询验证码日志列表' })
  @ApiResult({ type: [CaptchaLogEntity], isPage: true })
  @Perm(permissions.CAPTCHALIST)
  captchaLogList(
    @Query() dto: CaptchaLogQueryDto,
  ): Promise<Pagination<CaptchaLogEntity>> {
    return this.captchaLogService.list(dto);
  }

  @Delete('captcha/delete')
  @ApiOperation({ summary: ' 批量删除验证码日志' })
  @Perm(permissions.CAPTCHADELETE)
  async deleteCaptchaLog(@Body() dto: DeleteDto): Promise<void> {
    const { ids } = dto;
    await this.captchaLogService.deleteLogs(ids);
  }
}
