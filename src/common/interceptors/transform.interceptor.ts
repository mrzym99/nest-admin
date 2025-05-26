import {
  CallHandler,
  ExecutionContext,
  HttpStatus,
  NestInterceptor,
} from '@nestjs/common';
import { map, Observable } from 'rxjs';
import { ResOp } from '../model/response.model';
import { BYPASS_KEY } from '../decorators/bypass.decorator';
import * as qs from 'qs';
import { FastifyRequest } from 'fastify';

export class TransformInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    // 使用了 @Bypass() 跳过拦截器
    const bypass = Reflect.getMetadata(BYPASS_KEY, context.getHandler());
    if (bypass) {
      return next.handle();
    }

    const http = context.switchToHttp();
    const request = http.getRequest<FastifyRequest>();
    // 处理 query 参数，将数组参数转换为数组,如：?a[]=1&a[]=2 => { a: [1, 2] }
    request.query = qs.parse(request.url.split('?').at(1));

    return next.handle().pipe(
      map((data) => {
        return new ResOp(HttpStatus.OK, data ?? null, '操作成功');
      }),
    );
  }
}
