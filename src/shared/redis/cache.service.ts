import { Cache } from 'cache-manager';
import { CACHE_MANAGER } from '@nestjs/cache-manager';
import { Inject, Injectable } from '@nestjs/common';
import { Emitter } from '@socket.io/redis-emitter';
import { RedisIoAdapterKey } from '~/common/adapters/socket.adapter';
import { API_CACHE_PREFIX } from '~/constants/cache.constant';
import { getRedisKey } from '~/utils';
import { InjectRedis } from '~/common/decorators/inject-redis.decorator';
import Redis from 'ioredis';

export type TCacheKey = string;
export type TCacheResult<I> = Promise<I | undefined>;

@Injectable()
export class CacheService {
  private cache: Cache;
  constructor(
    @Inject(CACHE_MANAGER) cache: Cache,
    @InjectRedis() private readonly redis: Redis,
  ) {
    this.cache = cache;
  }

  private get redisClient() {
    return this.redis;
  }

  public get<T>(ket: TCacheKey): TCacheResult<T> {
    return this.cache.get(ket);
  }

  public set<T>(key: TCacheKey, value: any, ttl?: number): TCacheResult<T> {
    return this.cache.set(key, value, ttl);
  }

  public getClient() {
    return this.redisClient;
  }

  private _emitter: Emitter;

  public get emitter(): Emitter {
    if (!this._emitter) {
      this._emitter = new Emitter(this.redisClient, {
        key: RedisIoAdapterKey,
      });
    }
    return this._emitter;
  }

  public async cleanApiCache() {
    const redis = this.getClient();
    const keys: string[] = await redis.keys(`${API_CACHE_PREFIX}*`);

    await Promise.all(keys.map((key) => redis.del(key)));
  }

  public async cleanAllRedisKey() {
    const redis = this.getClient();
    const keys: string[] = await redis.keys(getRedisKey('*'));
    await Promise.all(keys.map((key) => redis.del(key)));
  }
}
