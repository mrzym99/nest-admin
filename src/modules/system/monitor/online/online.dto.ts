import { ApiProperty } from '@nestjs/swagger';
import { IsNumber, IsOptional, IsString } from 'class-validator';
import { ToNumber } from '~/common/decorators/transform.decorator';
import { PagerDto } from '~/common/dto/pager.dto';

export class KickDto {
  @ApiProperty({ description: 'tokenId' })
  @IsNumber()
  @ToNumber()
  tokenId: number;
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
