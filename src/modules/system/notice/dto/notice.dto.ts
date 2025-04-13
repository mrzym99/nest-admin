import { ApiProperty, PartialType } from '@nestjs/swagger';
import {
  IsArray,
  IsEnum,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
} from 'class-validator';
import { ToNumber } from '~/common/decorators/transform.decorator';
import { OperatorDto } from '~/common/dto/operator.dto';
import { PagerDto } from '~/common/dto/pager.dto';

export class NoticeCreateDto extends OperatorDto {
  @ApiProperty({
    description: '公告名称',
  })
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiProperty({
    description: '公告类型',
  })
  @IsEnum([1, 2])
  @IsNumber()
  @ToNumber()
  type: number;

  @ApiProperty({
    description: '公告状态',
  })
  @IsNumber()
  @ToNumber()
  status: number;

  @ApiProperty({
    description: '公告内容',
  })
  @IsNotEmpty()
  @IsString()
  content: string;
}
export class NoticeUpdateDto extends PartialType(NoticeCreateDto) {}

export class NoticeQueryDto extends PagerDto {
  @ApiProperty({
    description: '公告名称',
  })
  @IsOptional()
  @IsString()
  name?: string;

  @ApiProperty({
    description: '公告类型',
  })
  @IsOptional()
  @IsNumber()
  @ToNumber()
  type?: number;
}

export class NoticeStatusDto extends OperatorDto {
  @ApiProperty({
    description: 'Notice id list',
  })
  @IsArray()
  ids: number[];

  @ApiProperty({
    description: '状态 1 0',
  })
  @IsEnum([1, 0])
  @ToNumber()
  status: number;
}
