import { ApiProperty } from '@nestjs/swagger';

export class Prefix {
  @ApiProperty({ description: '名称', type: String })
  name?: string;

  @ApiProperty({ description: 'key', type: String })
  prefix?: string;
}
