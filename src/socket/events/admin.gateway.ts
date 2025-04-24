import { JwtService } from '@nestjs/jwt';
import {
  GatewayMetadata,
  MessageBody,
  OnGatewayConnection,
  OnGatewayDisconnect,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';

import { Server } from 'socket.io';

import { AuthService } from '~/modules/auth/auth.service';
import { CacheService } from '~/shared/redis/cache.service';

import { createAuthGateway } from '../shared/auth.gateway';

const AuthGateway = createAuthGateway({
  namespace: '/admin',
});

@WebSocketGateway<GatewayMetadata>({
  namespace: '/admin',
  cors: {
    origin: '*',
  },
})
export class AdminEventsGateway
  extends AuthGateway
  implements OnGatewayConnection, OnGatewayDisconnect
{
  constructor(
    protected readonly jwtService: JwtService,
    protected readonly authService: AuthService,
    private readonly cacheService: CacheService,
  ) {
    super(jwtService, authService, cacheService);
  }

  @WebSocketServer()
  protected _server: Server;

  get server() {
    return this._server;
  }


  @SubscribeMessage('events')
  online(@MessageBody() data: any) {
    console.log('online');
  }
}
