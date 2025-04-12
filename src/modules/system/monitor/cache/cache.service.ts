import { Injectable } from '@nestjs/common';
import Redis from 'ioredis';
import { InjectRedis } from '~/common/decorators/inject-redis.decorator';
import { RedisKey } from '~/constants/cache.constant';
import { Prefix } from './cache.model';

@Injectable()
export class CacheService {
  constructor(
    @InjectRedis()
    private readonly redis: Redis,
  ) {}

  getPrefixList(): Prefix[] {
    const prefixList: Prefix[] = [
      {
        name: '图形验证码',
        prefix: RedisKey.CAPTCHA_IMG_PREFIX,
      },
      {
        name: 'token',
        prefix: RedisKey.AUTH_TOKEN_PREFIX,
      },
      {
        name: '用户权限',
        prefix: RedisKey.AUTH_PERM_PREFIX,
      },
      {
        name: '在线用户',
        prefix: RedisKey.ONLINE_USER_PREFIX,
      },
      {
        name: 'token黑名单',
        prefix: RedisKey.TOKEN_BLACKLIST_PREFIX,
      },
      {
        name: '强制下线名单',
        prefix: RedisKey.FORCED_OFFLINE_PREFIX,
      },
    ];
    return prefixList;
  }

  async getKeys(prefix: string): Promise<string[]> {
    return await this.redis.keys(prefix + '*');
  }

  async getValue(key: string): Promise<string> {
    return await this.redis.get(key);
  }

  async delKey(key: string): Promise<number> {
    return await this.redis.del(key);
  }

  async clearCache(): Promise<void> {
    const keys = await this.redis.keys('*');
    if (keys.length > 0) {
      await this.redis.del(keys);
    }
  }

  async clearPrefixCache(prefix: string): Promise<void> {
    const keys = await this.redis.keys(prefix + '*');
    if (keys.length > 0) {
      await this.redis.del(keys);
    }
  }
}
