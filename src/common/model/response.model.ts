import { ApiProperty } from '@nestjs/swagger';
import {
  RESPONSE_SUCCESS_CODE,
  RESPONSE_SUCCESS_MESSAGE,
} from '~/constants/response.constant';

export class ResOp<T = any> {
  @ApiProperty({
    type: 'number',
    default: 200,
  })
  code: number;

  @ApiProperty({
    type: 'object',
    additionalProperties: true,
  })
  data?: T;

  @ApiProperty({
    type: 'string',
    default: 'success',
  })
  message: string;

  constructor(code: number, data: T, message = RESPONSE_SUCCESS_MESSAGE) {
    this.code = code;
    this.data = data;
    this.message = message;
  }

  static success<T>(data?: T, message?: string) {
    return new ResOp(RESPONSE_SUCCESS_CODE, data, message);
  }

  static error(code: number, message) {
    return new ResOp(code, {}, message);
  }
}
