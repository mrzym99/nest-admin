import { Module } from '@nestjs/common';
import { LogController } from './log.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { LoginLogService } from './services/login-log.service';
import { LoginLogEntity } from './entities/login-log.entity';
import { TaskLogService } from './services/task-log.service';
import { TaskLogEntity } from './entities/task-log.entity';
import { CaptchaLogEntity } from './entities/captcha-log.entity';
import { CaptchaLogService } from './services/captcha-log.service';

const providers = [LoginLogService, TaskLogService, CaptchaLogService];

@Module({
  imports: [
    TypeOrmModule.forFeature([LoginLogEntity, TaskLogEntity, CaptchaLogEntity]),
  ],
  controllers: [LogController],
  providers: [...providers],
  exports: [TypeOrmModule, ...providers],
})
export class LogModule {}
