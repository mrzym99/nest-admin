import {
  BadRequestException,
  Inject,
  Injectable,
  LoggerService,
} from '@nestjs/common';
import { Mission } from '../mission.decorator';
import { WINSTON_MODULE_NEST_PROVIDER } from 'nest-winston';
import { MailerService } from '~/shared/mailer/mailer.service';

/**
 * 发送邮件
 */
type Mail = {
  to: string;
  subject: string;
  content: string;
};

@Injectable()
@Mission()
export class EmailJob {
  constructor(
    private readonly mailerService: MailerService,
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: LoggerService,
  ) {}

  async send(config: Mail): Promise<void> {
    if (config) {
      const { to, subject, content } = config;
      const result = await this.mailerService.send(
        to,
        subject,
        content,
        'html',
      );
      this.logger.log(result, 'EmailJob: ' + EmailJob.name);
    } else {
      throw new BadRequestException('EmailJob 参数为空');
    }
  }
}
