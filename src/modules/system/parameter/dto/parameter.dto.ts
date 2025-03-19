import { ApiProperty, PartialType } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString } from 'class-validator';
import { PagerDto } from '~/common/dto/pager.dto';

export class ParameterCreateDto {
  @ApiProperty({
    description: '参数名称',
  })
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiProperty({
    description: '参数键',
  })
  @IsNotEmpty()
  @IsString()
  key: string;

  @ApiProperty({
    description: '参数值',
  })
  @IsNotEmpty()
  @IsString()
  value: string;

  @ApiProperty({
    description: '参数备注',
  })
  @IsOptional()
  @IsString()
  remark?: string;
}
export class ParameterUpdateDto extends PartialType(ParameterCreateDto) {}

export class ParameterQueryDto extends PagerDto {
  @ApiProperty({
    description: '参数名称',
  })
  @IsOptional()
  @IsString()
  name?: string;

  @ApiProperty({
    description: '参数键',
  })
  @IsOptional()
  @IsString()
  key?: string;
}
