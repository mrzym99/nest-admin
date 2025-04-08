import type { RedisKey } from '~/constants/cache.constant';

type Prefix = 'nest-admin';
const prefix = 'nest-admin';

export function getRedisKey<T extends string = RedisKey | '*'>(
  key: T,
  ...concatKeys: string[]
): `${Prefix}:${T}${string | ''}` {
  return `${prefix}:${key}${
    concatKeys && concatKeys.length ? `:${concatKeys.join('_')}` : ''
  }`;
}
