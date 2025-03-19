import { ConfigType, registerAs } from '@nestjs/config';
import { env } from '~/utils';

export const ossRegToken = 'oss';

export const OssConfig = registerAs(ossRegToken, () => ({
  accessKey: env('OSS_ACCESS_KEY'),
  secretKey: env('OSS_SECRET_KEY'),
  domain: env('OSS_DOMAIN'),
  bucket: env('OSS_BUCKET'),
  zone: env('OSS_ZONE') || 'Zone_z2',
  access: env('OSS_ACCESS_TYPE') || 'public',
  region: env('OSS_REGION') || 'oss-cn-beijing',
  type: env('OSS_TYPE') || 'local',
}));

export type IOssConfig = ConfigType<typeof OssConfig>;
