import { Injectable } from '@nestjs/common';
import { Mission } from '../mission.decorator';
import { LoginLogService } from '~/modules/system/monitor/log/services/login-log.service';
import { TaskLogService } from '~/modules/system/monitor/log/services/task-log.service';
import { CaptchaLogService } from '~/modules/system/monitor/log/services/captcha-log.service';

@Injectable()
@Mission()
export class LogClearJob {
  constructor(
    private loginLogService: LoginLogService,
    private readonly taskLogService: TaskLogService,
    private readonly captchaLogService: CaptchaLogService,
  ) {}

  async clearLoginLog(): Promise<void> {
    await this.loginLogService.clearLog();
  }

  async clearTaskLog(): Promise<void> {
    await this.taskLogService.clearLog();
  }

  async clearCaptchaLog(): Promise<void> {
    await this.captchaLogService.clearLog();
  }
}
