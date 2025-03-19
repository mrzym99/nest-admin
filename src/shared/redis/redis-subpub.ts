import type { Redis, RedisOptions } from 'ioredis';
import IORedis from 'ioredis';

export class RedisSubPub {
  public pubClient: Redis; // 发布者
  public subClient: Redis; // 订阅者

  constructor(
    private redisConfig: RedisOptions,
    private channelPrefix: string = 'nest-admin-channel#',
  ) {}

  // 初始化 redis
  public init() {
    const redisOptions: RedisOptions = {
      host: this.redisConfig.host,
      port: this.redisConfig.port,
      password: this.redisConfig.password,
    };

    const pubClient = new IORedis(redisOptions);
    const subClient = pubClient.duplicate();
    this.pubClient = pubClient;
    this.subClient = subClient;
  }

  // 发布 消息
  public async publish(channel: string, data: any) {
    const channelName = this.channelPrefix + channel;

    const _data = JSON.stringify(data);
    if (channel !== 'log') {
      console.log(`[${channelName}]`, _data);
    }

    await this.pubClient.publish(channelName, _data);
  }

  // 用于存储 callback 和 cb 对应
  private ctc = new WeakMap<(data: any) => void, (channel, message) => void>();
  /**
   * 订阅频道
   * @param channel 频道名称
   * @param callback 回调函数
   */
  public async subscribe(channel: string, callback: (data: any) => void) {
    const channelName = this.channelPrefix + channel;

    this.subClient.subscribe(channelName);

    const cb = (channel, message) => {
      if (channel !== channelName) {
        return;
      }

      const _data = JSON.parse(message);
      callback(_data);
    };
    this.ctc.set(callback, cb);
    this.subClient.on('message', cb);
  }

  /**
   * 取消订阅频道
   * @param channel 频道名称
   * @param callback 频道回调函数
   */
  public async unsubscribe(channel: string, callback: (data: any) => void) {
    const channelName = this.channelPrefix + channel;

    this.subClient.unsubscribe(channelName);
    const cb = this.ctc.get(callback);
    if (cb) {
      this.subClient.off('message', cb);
      this.ctc.delete(callback);
    }
  }
}
