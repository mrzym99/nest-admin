import { HttpException, HttpStatus } from '@nestjs/common';
import { ErrorEnum } from '~/constants/error.constant';
import { splitError } from '~/utils';

export class BusinessException extends HttpException {
  private errorCode: number;

  constructor(error: ErrorEnum | string) {
    const [code, message] = splitError(error);
    super(
      HttpException.createBody({
        code,
        message,
      }),
      HttpStatus.OK,
    );

    this.errorCode = code;
  }

  getErrorCode(): number {
    return this.errorCode;
  }
}

export { BusinessException as BizException };
