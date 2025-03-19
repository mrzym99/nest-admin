import { Module } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import * as winston from 'winston';
import { Console } from 'winston/lib/winston/transports';
import { utilities, WinstonModule } from 'nest-winston';
import * as DailyRotateFile from 'winston-daily-rotate-file';
import { AllConfigKeyAndPath, appRegToken } from '~/config';

@Module({
  imports: [
    WinstonModule.forRootAsync({
      useFactory: (configService: ConfigService<AllConfigKeyAndPath>) => {
        const { logger } = configService.get(appRegToken, { infer: true });
        const infoTransports = [
          new Console({
            level: logger.level,
            format: winston.format.combine(
              winston.format.timestamp(),
              utilities.format.nestLike(),
            ),
          }),
        ];
        const dailyTransport = [
          // new DailyRotateFile({
          //   level: 'warn',
          //   filename: 'logs/nest-%DATE%.log',
          //   datePattern: 'YYYY-MM-DD',
          //   zippedArchive: true,
          //   maxSize: '20m',
          //   maxFiles: '14d',
          //   format: winston.format.combine(
          //     winston.format.timestamp(),
          //     winston.format.simple(),
          //   ),
          // }),
          // 记录错误日志
          new DailyRotateFile({
            level: 'error',
            filename: 'logs/nest-%DATE%.log',
            datePattern: 'YYYY-MM-DD',
            zippedArchive: true,
            maxSize: '20m',
            maxFiles: '14d',
            format: winston.format.combine(
              winston.format.timestamp(),
              winston.format.simple(),
            ),
          }),
        ];

        return {
          transports: [...infoTransports, ...(logger.on ? dailyTransport : [])],
        };
      },
      inject: [ConfigService],
    }),
  ],
})
export class LoggerModule {}
