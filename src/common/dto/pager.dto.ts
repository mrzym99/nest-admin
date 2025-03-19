import { ApiProperty } from '@nestjs/swagger';
import { Expose, Transform } from 'class-transformer';
import { Allow, IsEnum, IsInt, IsOptional, Max, Min } from 'class-validator';
import { ToNumber } from '../decorators/transform.decorator';

export enum Order {
  ASC = 'ASC',
  DESC = 'DESC',
}

export class PagerDto {
  @ApiProperty({
    // swagger 显示
    minimum: 1,
    default: 1,
    description: '当前页码',
  })
  @Min(1) // 最小值
  @IsInt() // 必须是数字
  @Expose() // 显示
  @IsOptional({ always: true }) // 可选
  @ToNumber(1)
  currentPage: number;

  @ApiProperty({
    minimum: 1,
    maximum: 999,
    default: 10,
    description: '每页条数',
  })
  @Min(1)
  @Max(999)
  @IsInt()
  @Expose()
  @IsOptional({ always: true })
  @ToNumber(10)
  pageSize: number;

  @ApiProperty({
    enum: Order, // 枚举
    required: false,
  })
  @IsEnum(Order, { always: true })
  @IsOptional({ always: true })
  @Transform(({ value }) => (value === 'asc' ? Order.ASC : Order.DESC))
  order?: string;

  @Allow() // 忽略
  _t?: number; // 时间戳
}
