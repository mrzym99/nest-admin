import { Module } from '@nestjs/common';
import { TaskService } from './task.service';
import { TaskController } from './task.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TaskEntity } from './task.entity';
import { BullModule } from '@nestjs/bull';
import { SYS_TASK_QUEUE_NAME } from './constant';
import { ConfigService } from '@nestjs/config';
import { AllConfigKeyAndPath, IRedisConfig } from '~/config';
import { LogModule } from '../log/log.module';
import { TaskConsumer } from './task.processor';

const providers = [TaskService, TaskConsumer];

@Module({
  imports: [
    TypeOrmModule.forFeature([TaskEntity]),
    BullModule.registerQueueAsync({
      name: SYS_TASK_QUEUE_NAME,
      useFactory: (configService: ConfigService<AllConfigKeyAndPath>) => {
        return {
          redis: configService.get<IRedisConfig>('redis'),
          prefix: SYS_TASK_QUEUE_NAME,
        };
      },
      inject: [ConfigService],
    }),
    LogModule,
  ],
  controllers: [TaskController],
  providers: [...providers],
  exports: [TypeOrmModule, ...providers],
})
export class TaskModule {}
