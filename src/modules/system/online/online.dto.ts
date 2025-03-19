import { ApiProperty } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';
import { PagerDto } from '~/common/dto/pager.dto';

export class KickDto {
  @ApiProperty({ description: 'tokenId' })
  @IsString()
  tokenId: string;
}

export class OnlineQueryDto extends PagerDto {
  @ApiProperty({ description: 'username' })
  @IsOptional()
  @IsString()
  username?: string;

  @ApiProperty({ description: 'nickName' })
  @IsOptional()
  @IsString()
  nickName?: string;
}
