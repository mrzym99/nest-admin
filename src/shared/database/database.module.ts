import { Module } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { databaseRegToken } from '~/config';
import { UniqueConstraint } from './constraints/unique.constraint';

const providers = [UniqueConstraint];

@Module({
  imports: [
    TypeOrmModule.forRootAsync({
      useFactory: (configService: ConfigService) => {
        const dataSourceOptions = configService.get(databaseRegToken);
        return {
          ...dataSourceOptions,
          // cli: {
          //   migrationsDir: 'src/migrations',
          // },
        };
      },
      inject: [ConfigService],
    }),
  ],
  providers,
  exports: providers,
})
export class DatabaseModule {}
