import { CacheModule } from '@nestjs/cache-manager';
import { Global, Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import {
  RedisModule as NestRedisModule,
  RedisService,
} from '@liaoliaots/nestjs-redis';
import { AllConfigKeyAndPath } from '~/config';
import { IRedisConfig, redisRegToken } from '~/config/redis.config';
import { CacheService } from './cache.service';
import { REDIS_PUBSUB } from '~/constants/redis.constant';
import { RedisSubPub } from './redis-subpub';
import { RedisPubSubService } from './redis-subpub.service';
import { REDIS_CLIENT } from '~/common/decorators/inject-redis.decorator';
import { createKeyv } from '@keyv/redis';

const providers = [
  CacheService,
  {
    provide: REDIS_PUBSUB,
    useFactory: (configService: ConfigService<AllConfigKeyAndPath>) => {
      const redisOPtions = configService.get<IRedisConfig>(redisRegToken);
      return new RedisSubPub(redisOPtions);
    },
    inject: [ConfigService],
  },
  RedisPubSubService,
  {
    provide: REDIS_CLIENT,
    useFactory: (redisService: RedisService) => {
      return redisService.getOrThrow();
    },
    inject: [RedisService],
  },
];

@Global()
@Module({
  imports: [
    // cache
    CacheModule.registerAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService<AllConfigKeyAndPath>) => {
        const redisOPtions = configService.get<IRedisConfig>(redisRegToken);
        return {
          isGlobal: true,
          store: createKeyv('redis://localhost:6379'),
          isCacheableValue: () => true,
          ...redisOPtions,
        };
      },
      inject: [ConfigService],
    }),
    // redis
    NestRedisModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService<AllConfigKeyAndPath>) => {
        const redisOPtions = configService.get<IRedisConfig>(redisRegToken);
        return {
          config: {
            ...redisOPtions,
          },
        };
      },
      inject: [ConfigService],
    }),
  ],
  providers: [...providers],
  exports: [...providers, CacheModule],
})
export class RedisModule {}
