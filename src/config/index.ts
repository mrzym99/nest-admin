import { AppConfig, appRegToken, IAppConfig } from './app.config';
import {
  DatabaseConfig,
  databaseRegToken,
  IDatabaseConfig,
} from './database.config';
import { IMailerConfig, MailerConfig, mailerRegToken } from './mailer.config';
import { IOssConfig, OssConfig, ossRegToken } from './oss.config';
import { IRedisConfig, RedisConfig, redisRegToken } from './redis.config';
import {
  ISecurityConfig,
  SecurityConfig,
  securityRegToken,
} from './security.config';

export * from './app.config';
export * from './database.config';
export * from './mailer.config';
export * from './oss.config';
export * from './redis.config';
export * from './security.config';

export interface AllConfigType {
  [appRegToken]: IAppConfig;
  [databaseRegToken]: IDatabaseConfig;
  [mailerRegToken]: IMailerConfig;
  [redisRegToken]: IRedisConfig;
  [securityRegToken]: ISecurityConfig;
  [ossRegToken]: IOssConfig;
}

export type AllConfigKeyAndPath = RecordNamePaths<AllConfigType>;

export default {
  AppConfig,
  DatabaseConfig,
  MailerConfig,
  OssConfig,
  RedisConfig,
  SecurityConfig,
};
