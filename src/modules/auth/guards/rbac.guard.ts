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
import { AllConfigKeyAndPath } from '~/config';
import { ParameterService } from '~/modules/system/parameter/parameter.service';
import { ParameterKey } from '~/constants/parameter.constant';
import { FastifyRequest } from 'fastify';

@Injectable()
export class RbacGuard implements CanActivate {
  constructor(
    private readonly reflector: Reflector,
    private readonly authService: AuthService,
    private readonly configService: ConfigService<AllConfigKeyAndPath>,
    private readonly parameterService: ParameterService,
  ) {}

  async canActivate(context: ExecutionContext): Promise<any> {
    // getAllAndOverride 获取所有装饰器修饰的元数据 也就是会考虑类和方法上的装饰器
    const isPublic = this.reflector.getAllAndOverride<boolean>(PUBLIC_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);
    if (isPublic) return true;

    const request = context.switchToHttp().getRequest<FastifyRequest>();

    const { user } = request;
    if (!user) throw new UnauthorizedException(ErrorEnum.LOGIN_FIRST);

    const canModifyData = await this.parameterService.findOneByKey(
      ParameterKey.AUTH_MODIFY_ENABLE,
    );

    // get 方法只会获取当前方法上的元数据 局部的
    const allowAnon = this.reflector.get<boolean>(
      ALLOW_ANON_KEY,
      context.getHandler(),
    );

    // 超级管理员在任何情况下都有权限
    if (user.roles.includes(Roles.SUPERADMIN)) {
      return true;
    }

    // 如果当前方法设置了 allowAnon 则直接通过
    if (allowAnon) return true;

    // 如果不能修改数据 则 只能访问 get 请求
    if (canModifyData !== 'true' && request.method !== 'GET') {
      throw new BusinessException(ErrorEnum.AUTH_DEMO_NO_OPERATE);
    }

    const payloadPermission = this.reflector.getAllAndOverride<
      string | string[]
    >(PERMISSION_KEY, [context.getHandler(), context.getClass()]);

    // 控制器未设置权限则通过
    if (!payloadPermission) return true;

    const allPermissions = await this.authService.getPermissionsCache(user.uid);

    let canNext = false;
    if (Array.isArray(payloadPermission)) {
      canNext = payloadPermission.every((permission) =>
        allPermissions.includes(permission),
      );
    } else if (typeof payloadPermission === 'string') {
      canNext = allPermissions.includes(payloadPermission);
    }

    if (!canNext) throw new BusinessException(ErrorEnum.AUTH_NO_PERMISSION);

    return true;
  }
}
