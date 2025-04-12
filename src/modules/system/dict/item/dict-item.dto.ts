import { ApiProperty, PartialType } from '@nestjs/swagger';
import {
  IsArray,
  IsEnum,
  IsInt,
  IsNumber,
  IsOptional,
  IsString,
  MinLength,
} from 'class-validator';
import { ToNumber } from '~/common/decorators/transform.decorator';
import { OperatorDto } from '~/common/dto/operator.dto';
import { PagerDto } from '~/common/dto/pager.dto';

export class DictItemCreateDto {
  @ApiProperty({ description: '字典类型 ID', required: true })
  @IsNumber()
  @ToNumber()
  typeId: number;

  @ApiProperty({ description: '字典项名称', required: true })
  @IsString()
  @MinLength(1)
  label: string;

  @ApiProperty({ description: '字典项值', required: true })
  @IsString()
  @MinLength(1)
  value: string;

  @ApiProperty({ description: '排序' })
  @IsOptional()
  @IsInt()
  order?: number;

  @ApiProperty({ description: '状态' })
  @IsEnum([0, 1])
  @IsOptional()
  @ToNumber()
  status?: number;

  @ApiProperty({ description: '备注' })
  @IsOptional()
  @IsString()
  remark?: string;
}

export class DictItemUpdateDto extends PartialType(DictItemCreateDto) {}

export class DictItemQueryDto extends PagerDto {
  @ApiProperty({ description: '字典类型 ID', required: true })
  @IsNumber()
  @ToNumber()
  typeId: number;

  @ApiProperty({ description: '字典项名称' })
  @IsOptional()
  @IsString()
  label?: string;

  @ApiProperty({ description: '字典项值' })
  @IsOptional()
  @IsString()
  value?: string;
}

export class DictItemStatusDto extends OperatorDto {
  @ApiProperty({
    description: 'DictItem ID数组',
  })
  @IsArray()
  ids: string[];

  @ApiProperty({
    description: '状态 1 0',
  })
  @IsEnum([1, 0])
  @ToNumber()
  status: number;
}
