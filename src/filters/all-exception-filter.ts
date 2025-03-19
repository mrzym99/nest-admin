import {
  ArgumentsHost,
  Catch,
  ExceptionFilter,
  HttpException,
  HttpStatus,
  Logger,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { HttpAdapterHost } from '@nestjs/core';
import { ThrottlerException } from '@nestjs/throttler';
import { BizException } from '~/common/exceptions/biz.exception';
import { AllConfigKeyAndPath } from '~/config';
import { ErrorEnum } from '~/constants/error.constant';
import { isDev, splitError } from '~/utils';

interface HttpError {
  readonly status: number;
  readonly statusCode: number;
  readonly message: string;
}

@Catch() // 这里不指定类型 就是捕获所有类型的异常
export class AllExceptionFilter implements ExceptionFilter {
  constructor(
    private logger: Logger,
    private readonly httpAdapterHost: HttpAdapterHost,
    private readonly configService: ConfigService<AllConfigKeyAndPath>,
  ) {}
  catch(exception: unknown, host: ArgumentsHost) {
    const { httpAdapter } = this.httpAdapterHost;
    const ctx = host.switchToHttp();

    const request = ctx.getRequest();
    const response = ctx.getResponse();

    const httpStatus = this.getStatus(exception);

    // 此 result 用于开发时用
    let message = this.getMessage(exception);

    let code;
    if (exception instanceof BizException) {
      code = exception.getErrorCode();
    } else if (exception instanceof ThrottlerException) {
      const [errCode, errorMessage] = splitError(ErrorEnum.TOO_MANY_REQUESTS);
      code = errCode || httpStatus;
      message = errorMessage || message;
    } else {
      const [errCode, errorMessage] = splitError(message);
      code = errCode || httpStatus;
      message = errorMessage || message;
    }

    const result = isDev
      ? {
          code,
          message,
          path: httpAdapter.getRequestUrl(request),
          method: request.method,
          params: request.params,
          query: request.query,
          body: request.body,
          timestamp: new Date().toISOString(),
        }
      : { code, message };

    if (isDev) {
      console.log(exception);
    }
    // 这里是为了 用户手动抛出其他类型异常有值时，合并到 result

    // this.logger.error('[xiaozhang]', exception);

    httpAdapter.reply(response, result, httpStatus);
  }

  getStatus(exception: unknown): number {
    if (exception instanceof HttpException) {
      return exception.getStatus();
    }

    // return HttpStatus.INTERNAL_SERVER_ERROR;
    return (
      (exception as HttpError).status ||
      (exception as HttpError).statusCode ||
      HttpStatus.INTERNAL_SERVER_ERROR
    );
  }

  getMessage(exception: unknown): string {
    if (exception instanceof HttpException) {
      return exception.message;
    }

    return (
      (exception as any).response?.message ||
      (exception as HttpError).message ||
      exception
    );
  }
}
