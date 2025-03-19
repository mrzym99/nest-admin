import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { AuthService } from '../auth.service';
import {
  ALLOW_ANON_KEY,
  PERMISSION_KEY,
  PUBLIC_KEY,
  Roles,
} from '../auth.constant';
import { BusinessException } from '~/common/exceptions/biz.exception';
import { ErrorEnum } from '~/constants/error.constant';
import { ConfigService } from '@nestjs/config';
import { AllConfigKeyAndPath, IAppConfig } from '~/config';

@Injectable()
export class RbacGuard implements CanActivate {
  constructor(
    private readonly reflector: Reflector,
    private readonly authService: AuthService,
    private readonly configService: ConfigService<AllConfigKeyAndPath>,
  ) {}

  async canActivate(context: ExecutionContext): Promise<any> {
    // getAllAndOverride 获取所有装饰器修饰的元数据 也就是会考虑类和方法上的装饰器
    const isPublic = this.reflector.getAllAndOverride<boolean>(PUBLIC_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);
    if (isPublic) return true;

    const request = context.switchToHttp().getRequest<ExpressRequest>();

    const { user } = request;
    if (!user) throw new UnauthorizedException(ErrorEnum.LOGIN_FIRST);

    // get 方法只会获取当前方法上的元数据 局部的
    const allowAnon = this.reflector.get<boolean>(
      ALLOW_ANON_KEY,
      context.getHandler,
    );

    if (allowAnon) return true;

    const payloadPermission = this.reflector.getAllAndOverride<
      string | string[]
    >(PERMISSION_KEY, [context.getHandler(), context.getClass()]);

    // 控制器未设置权限则通过
    if (!payloadPermission) return true;

    // 超级管理员才有权限
    if (user.roles.includes(Roles.SUPER_ADMIN)) {
      return true;
    }

    const allPermissions = await this.authService.getPermissionsCache(user.uid);

    let canNext = false;
    if (Array.isArray(payloadPermission)) {
      canNext = payloadPermission.every((permission) =>
        allPermissions.includes(permission),
      );
    } else if (typeof payloadPermission === 'string') {
      canNext = allPermissions.includes(payloadPermission);
    }

    // 这里限制了 只能访问 get 请求
    const isDemo = this.configService.get<IAppConfig>('app').mode === 'demo';
    if (isDemo && request.method !== 'GET') {
      throw new BusinessException(ErrorEnum.AUTH_DEMO_NO_OPERATE);
    }

    if (!canNext) throw new BusinessException(ErrorEnum.AUTH_NO_PERMISSION);

    return true;
  }
}
