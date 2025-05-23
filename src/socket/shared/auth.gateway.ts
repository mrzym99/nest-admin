import type {
  OnGatewayConnection,
  OnGatewayDisconnect,
} from '@nestjs/websockets';
import type { Socket } from 'socket.io';
import {} from '@nestjs/common';
import { OnEvent } from '@nestjs/event-emitter';
import { JwtService } from '@nestjs/jwt';
import { WebSocketServer } from '@nestjs/websockets';
import { Namespace } from 'socket.io';

import { TokenService } from '~/modules/auth/services/token.service';
import { CacheService } from '~/shared/redis/cache.service';

import { BroadcastBaseGateway } from '../base.gateway';
import { SocketEvents } from '../socket.constant';

export interface AuthGatewayOptions {
  namespace: string;
}

export interface IAuthGateway
  extends OnGatewayConnection,
    OnGatewayDisconnect {}

export function createAuthGateway(
  options: AuthGatewayOptions,
): new (...args: any[]) => IAuthGateway {
  const { namespace } = options;

  class AuthGateway extends BroadcastBaseGateway implements IAuthGateway {
    constructor(
      protected readonly jwtService: JwtService,
      protected readonly tokenService: TokenService,
      private readonly cacheService: CacheService,
    ) {
      super();
    }

    @WebSocketServer()
    protected namespace: Namespace;

    async authFailed(client: Socket) {
      client.send(
        this.gatewayMessageFormat(SocketEvents.AUTH_FAILED, '认证失败'),
      );
      client.disconnect();
    }

    async authToken(token: string): Promise<boolean> {
      if (typeof token !== 'string') return false;

      const validJwt = async () => {
        try {
          const ok = await this.jwtService.verifyAsync(token);

          if (!ok) return false;
        } catch {
          return false;
        }
        // is not crash, is verify
        return true;
      };

      return await validJwt();
    }

    async handleConnection(client: Socket) {
      const token =
        client.handshake.query.token ||
        client.handshake.headers.authorization ||
        client.handshake.headers.Authorization;

      if (!token) return this.authFailed(client);

      if (!(await this.authToken(token as string)))
        return this.authFailed(client);

      super.handleConnect(client);

      const sid = client.id;
      this.tokenSocketIdMap.set(token.toString(), sid);
    }

    handleDisconnect(client: Socket) {
      super.handleDisconnect(client);
    }

    tokenSocketIdMap = new Map<string, string>();

    @OnEvent(SocketEvents.TokenExpired)
    handleTokenExpired(token: string) {
      const server = this.namespace.server;
      const sid = this.tokenSocketIdMap.get(token);
      if (!sid) return false;

      const socket = server.of(`/${namespace}`).sockets.get(sid);
      if (socket) {
        super.handleDisconnect(socket);
        socket.disconnect();
        return true;
      }
      return false;
    }

    override broadcast(event: SocketEvents, data: any) {
      this.cacheService.emitter
        .of(`/${namespace}`)
        .emit('message', this.gatewayMessageFormat(event, data));
    }
  }

  return AuthGateway;
}
