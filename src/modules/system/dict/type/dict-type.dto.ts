import { ApiProperty, PartialType } from '@nestjs/swagger';
import { IsUnique } from '~/shared/database/constraints/unique.constraint';
import { DictTypeEntity } from './dict-type.entity';
import {
  IsArray,
  IsEnum,
  IsOptional,
  IsString,
  MinLength,
} from 'class-validator';
import { ToNumber } from '~/common/decorators/transform.decorator';
import { PagerDto } from '~/common/dto/pager.dto';

export class DictTypeCreateDto {
  @ApiProperty({ description: '字典类型名称' })
  @IsUnique({ entity: DictTypeEntity, message: '已存在相同名称的字典' })
  @IsString()
  @MinLength(1)
  name: string;

  @ApiProperty({ description: '字典类型code' })
  @IsUnique({ entity: DictTypeEntity, message: '已存在相同编码的字典' })
  @IsString()
  @MinLength(3)
  code: string;

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

export class DictTypeUpdateDto extends PartialType(DictTypeCreateDto) {}

export class DictTypeQueryDto extends PagerDto {
  @ApiProperty({ description: '字典类型名称' })
  @IsOptional()
  @IsString()
  name?: string;

  @ApiProperty({ description: '字典类型code' })
  @IsOptional()
  @IsString()
  code?: string;
}

export class DictTypeStatusDto {
  @ApiProperty({
    description: 'DictType ID数组',
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
