import { Module } from '@nestjs/common';
import { MailController } from './mail.controller';
import { LogModule } from '~/modules/system/log/log.module';
import { MailerService } from '~/shared/mailer/mailer.service';

@Module({
  imports: [LogModule],
  controllers: [MailController],
})
export class MailModule {}
