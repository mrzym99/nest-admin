import { ConfigType, registerAs } from '@nestjs/config';
import { env, envBoolean, envNumber } from '~/utils';

export const appRegToken = 'app';

const globalPrefix = env('GLOBAL_PREFIX');

export const RouterWhiteList: string[] = [
  `${globalPrefix ? '/' : ''}${globalPrefix}/auth/captcha/img`,
  `${globalPrefix ? '/' : ''}${globalPrefix}/auth/login`,
  `${globalPrefix ? '/' : ''}${globalPrefix}/auth/register`,
  `${globalPrefix ? '/' : ''}${globalPrefix}/`,
];

export const AppConfig = registerAs(appRegToken, () => ({
  name: env('APP_NAME'),
  port: envNumber('APP_PORT', 3000),
  baseUrl: env('APP_BASE_URL'),
  globalPrefix,
  locale: env('APP_LOCALE', 'zh-CN'),
  // 多端登录
  multiDeviceLogin: envBoolean('MULTI_DEVICE_LOGIN', true),

  logger: {
    on: envBoolean('LOG_ON', false),
    level: env('LOG_LEVEL', 'info'),
    maxFiles: envNumber('LOG_MAX_FILES', 10),
  },
}));

export type IAppConfig = ConfigType<typeof AppConfig>;
