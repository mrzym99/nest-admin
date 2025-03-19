import {
  PipeTransform,
  Injectable,
  ArgumentMetadata,
  HttpStatus,
  UnprocessableEntityException,
} from '@nestjs/common';
import { validate } from 'class-validator';
import { plainToClass } from 'class-transformer';

@Injectable()
export class ValidationPipe implements PipeTransform<any> {
  async transform(value: any, { metatype }: ArgumentMetadata) {
    // 如果没有 metatype 或者不是 class-validator 支持的类型，则不进行验证
    if (!metatype || !this.toValidate(metatype)) {
      return value;
    }

    const object = plainToClass(metatype, value, {
      enableImplicitConversion: false, // 不要让class-transformer自动进行隐式转换
    });

    const errors = await validate(object, {
      whitelist: true, // 移除非白名单属性
      errorHttpStatusCode: HttpStatus.UNPROCESSABLE_ENTITY, // 422
      stopAtFirstError: true, // 在遇到错误时停止验证
      forbidNonWhitelisted: false, // 禁止 无装饰器验证的数据通过
    });

    if (errors.length > 0) {
      throw new UnprocessableEntityException(
        errors.map((error) => {
          const rule = Object.keys(error.constraints)![0];
          const msg = error.constraints![rule];
          return msg;
        })[0],
      );
    }
    return object;
  }

  private toValidate(metatype: new (...args: any[]) => any): boolean {
    const types: (new (...args: any[]) => any)[] = [
      String,
      Boolean,
      Number,
      Array,
      Object,
    ];
    return !types.includes(metatype);
  }
}
