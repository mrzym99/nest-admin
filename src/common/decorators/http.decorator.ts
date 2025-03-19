import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { getIp } from '~/utils/ip.util';

export const Ip = createParamDecorator((_, context: ExecutionContext) => {
  const request = context.switchToHttp().getRequest<Request>();
  return getIp(request);
});
