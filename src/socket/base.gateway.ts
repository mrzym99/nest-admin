import type { Socket } from 'socket.io'

import { SocketEvents } from './socket.constant'

export abstract class BaseGateway {
  public gatewayMessageFormat(
    type: SocketEvents,
    message: any,
    code?: number,
  ) {
    return {
      type,
      data: message,
      code,
    }
  }

  handleDisconnect(client: Socket) {
    // send 没有类型 前端用 on('message') 接收
    client.send(
      this.gatewayMessageFormat(SocketEvents.DISCONNECT, 'WebSocket 断开'),
    )
  }

  handleConnect(client: Socket) {
    client.send(
      this.gatewayMessageFormat(SocketEvents.CONNECT, 'WebSocket 已连接'),
    )
  }
}

export abstract class BroadcastBaseGateway extends BaseGateway {
  broadcast(event: SocketEvents, data: any) {}
}
