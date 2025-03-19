import { ApiProperty } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';
import { PagerDto } from '~/common/dto/pager.dto';

export class OssPageDto extends PagerDto {
  @ApiProperty({ description: '文件名' })
  @IsOptional()
  @IsString()
  name?: string;
}
