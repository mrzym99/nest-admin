import {
  HttpStatus,
  NotAcceptableException,
  Param,
  ParseIntPipe,
} from '@nestjs/common';

/**
 * param 传过来的时候会变成 string 类型
 * 需要将 id 参数解析为数字类型
 */
export function ParamId() {
  return Param(
    'id',
    new ParseIntPipe({
      errorHttpStatusCode: HttpStatus.NOT_ACCEPTABLE,
      exceptionFactory: (_error) => {
        throw new NotAcceptableException('id 格式不正确');
      },
    }),
  );
}
