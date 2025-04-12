import {
  BeforeApplicationShutdown,
  Controller,
  Ip,
  Param,
  Req,
  Res,
  Sse,
  Headers,
  ParseIntPipe,
} from '@nestjs/common';
import { SseService, MessageEvent } from './sse.service';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { SkipThrottle } from '@nestjs/throttler';
import { OnlineService } from '../system/monitor/online/online.service';
import { interval, Observable, Subscriber } from 'rxjs';

@ApiTags('Sse - sse模块')
@ApiSecurityAuth()
@SkipThrottle() // 跳过限流机制
@Controller('sse')
export class SseController implements BeforeApplicationShutdown {
  private replayMap: Map<string, Subscriber<MessageEvent>[]> = new Map();
  constructor(
    private readonly sseService: SseService,
    private readonly onlineService: OnlineService,
  ) {}

  private closeAllConnection() {
    this.sseService.sendToAllClients({
      type: 'close',
      data: '江湖再见～',
    });
  }

  beforeApplicationShutdown() {
    this.closeAllConnection();
  }

  @ApiOperation({ summary: 'sse连接' })
  @Sse(':uid')
  async sse(
    @Param('uid', ParseIntPipe) uid: number,
    @Req() req: ExpressRequest,
    @Res() res: Subscriber<MessageEvent>[],
    @Ip() ip: string,
    @Headers('user-agent') ua: string,
  ): Promise<Observable<any>> {
    this.replayMap.set(String(uid), res);

    // 上线用户
    this.onlineService.addOnlineUser(req.accessToken, ip, ua);

    return new Observable((subscriber) => {
      // 定时推送 保持连接
      const subscription = interval(12000).subscribe(() => {
        subscriber.next({
          type: 'ping',
        });
      });

      this.sseService.addClient(uid, subscriber);

      req.on('close', () => {
        subscription.unsubscribe();
        this.sseService.removeClient(uid, subscriber);
        this.replayMap.delete(String(uid));
        this.onlineService.removeOnlineUser(req.accessToken);
        console.log(`user-${uid} 断开连接`);
      });
    });
  }
}
