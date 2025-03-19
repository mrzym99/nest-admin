import { createParamDecorator, ExecutionContext } from '@nestjs/common';

type Payload = keyof IAuthUser;

/**
 * 获取当前挂载到request上的用户信息 前提是前面必须使用AuthGuard
 */
export const AuthUser = createParamDecorator(
  (data: Payload, ctx: ExecutionContext) => {
    const request = ctx.switchToHttp().getRequest();
    const user = request.user;
    return data ? user?.[data] : user;
  },
);
