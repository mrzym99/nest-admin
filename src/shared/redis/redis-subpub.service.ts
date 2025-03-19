import { Inject, Injectable } from '@nestjs/common';
import { REDIS_PUBSUB } from '~/constants/redis.constant';
import { RedisSubPub } from './redis-subpub';

@Injectable()
export class RedisPubSubService {
  constructor(@Inject(REDIS_PUBSUB) private redisSubPub: RedisSubPub) {}

  public async publish(channel: string, data: any) {
    return this.redisSubPub.publish(channel, data);
  }

  public async subscribe(channel: string, callback: (data: any) => void) {
    return this.redisSubPub.subscribe(channel, callback);
  }

  public async unsubscribe(channel: string, callback: (data: any) => void) {
    return this.redisSubPub.unsubscribe(channel, callback);
  }
}
