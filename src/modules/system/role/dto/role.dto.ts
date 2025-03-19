import { ApiProperty, PartialType } from '@nestjs/swagger';
import {
  IsArray,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Matches,
  MinLength,
} from 'class-validator';
import { ToNumber } from '~/common/decorators/transform.decorator';
import { PagerDto } from '~/common/dto/pager.dto';

export class RoleCreateDto {
  @ApiProperty({
    description: '角色名称',
    example: '管理员',
  })
  @IsString()
  @MinLength(2, { message: '角色名称不能小于2个字符' })
  name: string;

  @ApiProperty({
    description: '角色标识',
    example: 'admin',
  })
  @IsString()
  @Matches(/^[a-zA-Z0-9]+$/, { message: '角色标识只能是字母和数字' })
  @MinLength(2, { message: '角色标识不能小于2个字符' })
  value: string;

  @ApiProperty({
    description: '角色描述',
    example: '管理员',
  })
  @IsString()
  @IsOptional()
  description?: string;

  @ApiProperty({
    description: '角色状态 0 禁用 1 启用',
    example: 1,
  })
  @IsIn([0, 1])
  status: number;

  @ApiProperty({
    description: '是否系统默认角色',
    example: 0,
  })
  @IsIn([0, 1])
  @ToNumber()
  default: number;

  @ApiProperty({
    description: '角色关联的菜单id列表',
  })
  @IsOptional()
  @IsArray()
  menuIds?: string[];
}

export class RoleUpdateDto extends PartialType(RoleCreateDto) {}

export class RoleQueryDto extends PagerDto {
  @ApiProperty({
    description: '角色名称',
  })
  @IsOptional()
  @IsString()
  name?: string;

  @ApiProperty({
    description: '角色值',
  })
  @IsOptional()
  @IsString()
  value?: string;

  @ApiProperty({
    description: '状态',
  })
  @IsOptional()
  @IsInt()
  @ToNumber()
  @IsIn([0, 1])
  status?: number;
}
