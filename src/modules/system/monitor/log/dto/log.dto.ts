import { ApiProperty } from '@nestjs/swagger';
import { IsArray, IsOptional, IsString } from 'class-validator';
import { PagerDto } from '~/common/dto/pager.dto';

export class LoginLogCreateDto {
  @ApiProperty({ description: '用户id' })
  userId: number;

  @ApiProperty({ description: '登录ip' })
  ip: string;

  @ApiProperty({ description: '浏览器ua' })
  userAgent: string;
}

export class LoginLogQueryDto extends PagerDto {
  @ApiProperty({ description: '用户名' })
  @IsString()
  @IsOptional()
  username?: string;

  @ApiProperty({ description: '登录ip' })
  @IsString()
  @IsOptional()
  ip?: string;

  @ApiProperty({ description: '浏览器ua' })
  @IsString()
  @IsOptional()
  userAgent?: string;

  @ApiProperty({ description: '登录地点' })
  @IsString()
  @IsOptional()
  address?: string;

  @ApiProperty({ description: '登录时间' })
  @IsOptional()
  @IsArray()
  time?: string[];
}

export class TaskLogQueryDto extends PagerDto {
  @ApiProperty({ description: '任务名称' })
  @IsOptional()
  @IsString()
  name?: string;

  @ApiProperty({ description: '任务状态' })
  @IsOptional()
  status?: number;
}

export class CaptchaLogQueryDto extends PagerDto {
  @ApiProperty({ description: '账户' })
  @IsOptional()
  @IsString()
  account?: string;

  @ApiProperty({ description: '验证码提供商' })
  @IsOptional()
  provider?: string;
}
