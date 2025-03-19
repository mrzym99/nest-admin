import { ApiProperty, PartialType } from '@nestjs/swagger';
import {
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Min,
  MinLength,
} from 'class-validator';
import { ToNumber } from '~/common/decorators/transform.decorator';

export class DeptCreateDto {
  @ApiProperty({ description: '部门名称' })
  @IsString()
  @MinLength(1)
  name: string;

  @ApiProperty({ description: '父级id' })
  @IsString()
  @IsOptional()
  parentId: number;

  @ApiProperty({ description: '排序' })
  @IsInt()
  @IsOptional()
  @Min(0)
  @ToNumber(1)
  order: number;

  @ApiProperty({ description: '是否系统默认' })
  @IsOptional()
  @IsIn([0, 1])
  @ToNumber()
  default: number;
}

export class DeptUpdateDto extends PartialType(DeptCreateDto) {}

export class DeptQueryDto {
  @ApiProperty({ description: '部门名称' })
  @IsString()
  @IsOptional()
  name?: string;
}
