import { Global, Module } from '@nestjs/common';
import { LoggerModule } from './logger/logger.module';
import { RedisModule } from './redis/redis.module';
import { MailerModule } from './mailer/mailer.module';
// 发送 http 请求
import { HttpModule } from '@nestjs/axios';
import { ScheduleModule } from '@nestjs/schedule';
import { ThrottlerModule } from '@nestjs/throttler';
import { EventEmitterModule } from '@nestjs/event-emitter';
import { isDev } from '~/utils';
import { HelperModule } from './helper/helper.module';

@Global()
@Module({
  imports: [
    LoggerModule,
    HttpModule,
    ScheduleModule.forRoot(),
    // rate limit
    ThrottlerModule.forRoot([
      {
        limit: 20, // 每个客户端 1 分钟最多发送20次请求
        ttl: 60000,
      },
    ]),
    EventEmitterModule.forRoot({
      wildcard: true,
      delimiter: '.',
      newListener: false,
      removeListener: false,
      maxListeners: 20,
      verboseMemoryLeak: isDev,
      ignoreErrors: false,
    }),
    RedisModule,
    MailerModule,
    HelperModule,
  ],
  exports: [HttpModule, RedisModule, MailerModule, LoggerModule],
})
export class SharedModule {}
