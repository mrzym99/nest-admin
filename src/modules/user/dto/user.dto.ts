import { ApiProperty } from '@nestjs/swagger';
import {
  IsArray,
  IsDate,
  IsEmail,
  IsEnum,
  IsIn,
  IsInt,
  IsOptional,
  IsPhoneNumber,
  IsString,
  MaxLength,
} from 'class-validator';
import { Unique } from 'typeorm';
import { ToDate, ToNumber } from '~/common/decorators/transform.decorator';
import { PagerDto } from '~/common/dto/pager.dto';

export class UserQueryDto extends PagerDto {
  @ApiProperty({
    description: '用户名',
    required: false,
  })
  @IsString()
  @IsOptional({ always: true })
  username?: string;

  @ApiProperty({
    description: '昵称',
    required: false,
  })
  @IsString()
  @IsOptional()
  nickName?: string;

  @ApiProperty({
    description: '邮箱',
    required: false,
  })
  @IsString()
  @IsOptional()
  email?: string;

  @ApiProperty({
    description: '手机号',
    required: false,
  })
  @IsString()
  @IsOptional()
  phone?: string;

  @ApiProperty({
    description: '状态 1 启用 0 禁用',
    required: false,
  })
  @IsEnum([0, 1])
  @IsOptional()
  @ToNumber()
  status?: number;

  @ApiProperty({
    description: '部门',
    required: false,
  })
  @IsArray()
  @IsOptional()
  deptIds?: string[];

  @ApiProperty({
    description: '角色',
    required: false,
  })
  @IsString()
  @IsOptional()
  roleId?: string;
}

export class UserProfileDto {
  @ApiProperty({
    type: String,
    description: '账户',
    required: false,
  })
  @IsString()
  @IsOptional()
  username?: string;

  @ApiProperty({
    type: String,
    description: '昵称',
    example: 'Mick',
    required: false,
  })
  @IsString()
  @MaxLength(20)
  @IsOptional()
  nickName?: string;

  @ApiProperty({
    type: String,
    description: '性别 1 男 0 女',
    required: false,
  })
  @IsEnum([0, 1])
  @IsOptional()
  @ToNumber()
  gender?: number;

  @ApiProperty({
    type: String,
    description: '手机号',
    required: false,
  })
  @IsOptional()
  // @IsPhoneNumber('CN')
  phone?: string;

  @ApiProperty({
    type: String,
    description: '邮箱',
    required: false,
  })
  @IsString()
  @IsOptional()
  email?: string;

  @ApiProperty({
    type: String,
    description: '头像',
    required: false,
  })
  @IsString()
  @IsOptional()
  avatar?: string;

  @ApiProperty({
    type: String,
    description: '个人签名',
    required: false,
  })
  @IsString()
  @IsOptional()
  signature?: string;

  @ApiProperty({
    type: String,
    description: '地址',
    required: false,
  })
  @IsString()
  @IsOptional()
  address?: string;

  @ApiProperty({
    type: Date,
    nullable: true,
    description: '出生日期',
    required: false,
  })
  @IsDate()
  @IsOptional()
  @ToDate()
  birthDate?: Date;

  @ApiProperty({
    type: String,
    description: '简介',
    required: false,
  })
  @IsString()
  @IsOptional()
  introduction?: string;
}

export class UserCreateDto {
  @ApiProperty({
    type: String,
    description: '用户名',
    required: true,
  })
  @IsString({
    message: '用户名必须为字符串',
  })
  @Unique(['username'])
  username: string;

  @ApiProperty({
    type: String,
    description: '密码',
    required: true,
  })
  @IsString()
  password: string;

  @ApiProperty({
    type: Object,
    description: '用户详情',
  })
  @IsOptional()
  profile?: UserProfileDto;

  @ApiProperty({
    description: '邮箱',
  })
  @IsOptional()
  @IsEmail()
  email?: string;

  @ApiProperty({
    description: '角色',
  })
  @IsOptional()
  roleIds?: string[];

  @ApiProperty({
    description: '部门',
  })
  @IsOptional()
  deptId?: string;
}

export class UserStatusDto {
  @ApiProperty({
    description: '用户ID数组',
  })
  @IsArray()
  ids: string[];

  @ApiProperty({
    description: '状态',
  })
  @IsIn([0, 1])
  @ToNumber()
  status: number;
}

export class UserUpdateDto extends UserProfileDto {
  @ApiProperty({
    description: '角色',
  })
  @IsOptional()
  roleIds?: string[];

  @ApiProperty({
    description: '部门',
  })
  @IsOptional()
  deptId?: string;

  @ApiProperty({
    description: 'status',
  })
  @IsInt()
  @IsIn([0, 1])
  @ToNumber()
  status?: number;
}

export class UserPasswordDto {
  @ApiProperty({
    type: String,
    description: '旧密码',
    required: true,
  })
  @IsString()
  oldPassword: string;

  @ApiProperty({
    type: String,
    description: '新密码',
    required: true,
  })
  @IsString()
  newPassword: string;
}
