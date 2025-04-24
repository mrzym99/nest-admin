import { INestApplication } from '@nestjs/common'
import { createAdapter } from '@socket.io/redis-adapter'
import { IoAdapter } from '@nestjs/platform-socket.io'
import { REDIS_PUBSUB } from '~/constants/redis.constant'

export const RedisIoAdapterKey = 'nest-admin-socket'

export class RedisIoAdapter extends IoAdapter {
  constructor(private readonly app: INestApplication) {
    super(app)
  }

  createIOServer(port: number, options?: any) {
    const server = super.createIOServer(port, options)

    const { pubClient, subClient } = this.app.get(REDIS_PUBSUB)

    const redisAdapter = createAdapter(pubClient, subClient, {
      key: RedisIoAdapterKey,
      requestsTimeout: 10000,
    })
    server.adapter(redisAdapter)
    return server
  }
}
