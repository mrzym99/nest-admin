import {
  ExecutionContext,
  Inject,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { AuthStrategy, PUBLIC_KEY } from '../auth.constant';
import { ExtractJwt } from 'passport-jwt';
import { isEmpty } from 'lodash';
import { TokenService } from '../services/token.service';
import { AppConfig, IAppConfig, RouterWhiteList } from '~/config/app.config';
import { InjectRedis } from '~/common/decorators/inject-redis.decorator';
import Redis from 'ioredis';
import { genTokenBlacklistKey } from '~/helper/gen-redis-key';
import { ErrorEnum } from '~/constants/error.constant';
import { Reflector } from '@nestjs/core';
import { BusinessException } from '~/common/exceptions/biz.exception';
import { AuthService } from '../auth.service';

@Injectable()
export class JwtAuthGuard extends AuthGuard(AuthStrategy.JWT) {
  jwtFromRequestFn = ExtractJwt.fromAuthHeaderAsBearerToken();
  constructor(
    @InjectRedis() private readonly redis: Redis,
    private readonly tokenService: TokenService,
    private readonly reflector: Reflector,
    @Inject(AppConfig.KEY)
    private readonly appConfig: IAppConfig,
    private readonly authService: AuthService,
  ) {
    super();
  }

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest();

    if (RouterWhiteList.includes(request.path)) {
      return true;
    }

    // getAllAndOverride 获取所有装饰器修饰的元数据 也就是会考虑类和方法上的装饰器
    const isPublic = this.reflector.getAllAndOverride<boolean>(PUBLIC_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);
    if (isPublic) return true;

    const isSse = request.headers.accept === 'text/event-stream';

    if (isSse) {
      const { token } = request.query;
      if (token) request.headers.authorization = token;
    }

    const authorization = request.headers.authorization;

    if (!authorization) {
      throw new UnauthorizedException(ErrorEnum.LOGIN_FIRST);
    }

    if (!authorization.startsWith('Bearer ')) {
      request.headers.authorization = `Bearer ${authorization}`;
    }
    const token = await this.jwtFromRequestFn(request);

    // 检查是否在 redis 的token黑名单当中， 如果在的话 说明这个token被下线过/禁用 需要重新登录
    //  检查 token 是否在黑名单中
    if (await this.redis.get(genTokenBlacklistKey(token)))
      throw new UnauthorizedException(ErrorEnum.AUTH_INVALID_LOGIN);

    request.accessToken = token;

    let result: any = false;

    try {
      result = await super.canActivate(context);
    } catch (error) {
      if (isEmpty(token)) {
        throw new UnauthorizedException(ErrorEnum.LOGIN_FIRST);
      }

      const isValid = await this.tokenService.checkAccessToken(token);

      if (!isValid) {
        throw new BusinessException(ErrorEnum.AUTH_TOKEN_INVALID);
      }

      // SSE 请求
      if (isSse) {
        const { uid } = request.params;

        if (Number(uid) !== request.user.uid)
          throw new UnauthorizedException(
            '路径参数 uid 与当前 token 登录的用户 uid 不一致',
          );
      }

      // 不允许多端登录
      if (!this.appConfig.multiDeviceLogin) {
        const cacheToken = await this.authService.getTokenByUid(
          request.user.uid,
        );

        if (token !== cacheToken) {
          // 与redis保存不一致 即二次登录
          throw new BusinessException(ErrorEnum.AUTH_LOGGED_IN_ELSEWHERE);
        }
      }

      if (error instanceof UnauthorizedException) {
        throw new UnauthorizedException(ErrorEnum.AUTH_INVALID_LOGIN);
      }
    }

    return result;
  }
}
