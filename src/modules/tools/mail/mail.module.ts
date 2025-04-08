import { Module } from '@nestjs/common';
import { MailController } from './mail.controller';
import { LogModule } from '~/modules/system/monitor/log/log.module';

@Module({
  imports: [LogModule],
  controllers: [MailController],
})
export class MailModule {}
