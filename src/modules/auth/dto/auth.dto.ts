import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString } from 'class-validator';

export class LoginDto {
  @ApiProperty({
    description: '用户名',
    example: '12345@qq.com',
  })
  @IsNotEmpty()
  @IsString()
  username: string;

  @ApiProperty({
    description: '密码',
    example: '123456',
  })
  @IsNotEmpty()
  @IsString()
  password: string;

  @ApiProperty({
    description: '验证码',
    example: '123456',
  })
  @IsOptional()
  @IsString()
  code?: string;

  @ApiProperty({
    description: '验证码id',
  })
  @IsOptional()
  @IsString()
  captchaId: string;
}

export class RegisterDto {
  @ApiProperty({
    description: '用户名',
  })
  @IsString()
  @IsOptional()
  username?: string;

  @ApiProperty({
    description: '邮箱',
    example: '12345@qq.com',
  })
  @IsNotEmpty()
  @IsString()
  email: string;

  @ApiProperty({
    description: '密码',
  })
  @IsNotEmpty()
  @IsString()
  password: string;

  @ApiProperty({
    description: '验证码',
  })
  // @IsNotEmpty()
  @IsString()
  @IsOptional()
  code?: string;
}

export class PasswordUpdateDto {
  @ApiProperty({
    description: '邮箱',
    example: '12345@qq.com',
  })
  @IsNotEmpty()
  @IsString()
  email: string;

  @ApiProperty({
    description: '验证码',
  })
  // @IsNotEmpty()
  @IsString()
  @IsOptional()
  code?: string;

  @ApiProperty({
    description: '密码',
  })
  @IsNotEmpty()
  @IsString()
  password: string;
}

export class RefreshTokenDto {
  @ApiProperty({
    description: '刷新token',
  })
  @IsNotEmpty()
  @IsString()
  accessToken: string;
}
