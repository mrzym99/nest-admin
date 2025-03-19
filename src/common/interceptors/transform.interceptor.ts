import {
  CallHandler,
  ExecutionContext,
  HttpStatus,
  NestInterceptor,
} from '@nestjs/common';
import { map, Observable } from 'rxjs';
import { ResOp } from '../model/response.model';
import { BYPASS_KEY } from '../decorators/bypass.decorator';
export class TransformInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    // 使用了 @Bypass() 跳过拦截器
    const bypass = Reflect.getMetadata(BYPASS_KEY, context.getHandler());
    if (bypass) {
      return next.handle();
    }

    return next.handle().pipe(
      map((data) => {
        return new ResOp(HttpStatus.OK, data ?? null, '操作成功');
      }),
    );
  }
}
