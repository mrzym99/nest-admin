import { ConfigType, registerAs } from '@nestjs/config';
import { env } from '~/utils';

export const ossRegToken = 'oss';

export const OssConfig = registerAs(ossRegToken, () => ({
  secretId: env('OSS_SECRET_ID'),
  secretKey: env('OSS_SECRET_KEY'),
  domain: env('OSS_DOMAIN'),
  bucket: env('OSS_BUCKET'),
  region: env('OSS_REGION') || 'oss-cn-beijing',
  type: env('OSS_TYPE') || 'local',
}));

export type IOssConfig = ConfigType<typeof OssConfig>;
