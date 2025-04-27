import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsOptional, IsString } from 'class-validator';

export type ThirdLoginType = 'github'; // 可自行扩展

export class ThirdLoginUrlDto {
  @ApiProperty({ description: '三方登录的Code' })
  @IsString()
  code: string;
}

export class ThirdLoginCodeDto {
  @ApiProperty({ description: '三方登录的Code' })
  @IsString()
  code: string;

  @ApiProperty({ description: '三方登录的类型' })
  @IsString()
  @IsEnum(['github'])
  type: ThirdLoginType;
}

export class ThirdLoginCheckDto {
  @ApiProperty({ description: '三方登录的类型' })
  @IsString()
  @IsEnum(['github'])
  type: ThirdLoginType;

  @ApiProperty({ description: 'token_type' })
  @IsString()
  token_type: string;

  @ApiProperty({ description: 'token' })
  @IsString()
  access_token: string;
}

export class ThirdLoginDto {
  @ApiProperty({ description: '三方登录的类型' })
  @IsString()
  @IsEnum(['github'])
  type: ThirdLoginType;

  @ApiProperty({ description: 'token_type' })
  @IsString()
  token_type: string;

  @ApiProperty({ description: 'token' })
  @IsString()
  access_token: string;

  @ApiProperty({ description: 'username' })
  @IsString()
  @IsOptional()
  username?: string;

  @ApiProperty({ description: 'password' })
  @IsString()
  @IsOptional()
  password?: string;

  @ApiProperty({ description: 'from' })
  @IsString()
  @IsOptional()
  from?: string;

  @ApiProperty({ description: 'uniqueId' })
  @IsOptional()
  uniqueId?: number;

  @ApiProperty({ description: 'avatar' })
  @IsString()
  @IsOptional()
  avatar?: string;

  @ApiProperty({ description: 'address' })
  @IsString()
  @IsOptional()
  address?: string;

  @ApiProperty({ description: 'nickName' })
  @IsString()
  @IsOptional()
  nickName?: string;
}
