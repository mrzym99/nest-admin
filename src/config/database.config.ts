import { DataSource, DataSourceOptions } from 'typeorm';

import { ConfigType, registerAs } from '@nestjs/config';
import { env, envBoolean, envNumber } from '~/utils';

import * as dotenv from 'dotenv';
// 将 .env和对应环境env文件中的变量注入到 process.env 中
dotenv.config({
  path: ['.env', `.env.${process.env.NODE_ENV}`],
  override: true,
});

export const databaseRegToken = 'database';

const dataSourceOptions: DataSourceOptions = {
  type: env('DB_TYPE') as any,
  host: env('DB_HOST'),
  port: envNumber('DB_PORT'),
  username: env('DB_USERNAME'),
  password: env('DB_PASSWORD'),
  database: env('DB_DATABASE'),
  synchronize: envBoolean('DB_SYNCHRONIZE', false),
  logging: envBoolean('DB_LOGGING'),
  entities: ['dist/modules/**/*.entity{.ts,.js}'],
  migrations: ['src/migrations/**'],
};

export const DatabaseConfig = registerAs(
  databaseRegToken,
  (): DataSourceOptions => dataSourceOptions,
);

export type IDatabaseConfig = ConfigType<typeof DatabaseConfig>;

const dataSource = new DataSource(dataSourceOptions);

export default dataSource;
