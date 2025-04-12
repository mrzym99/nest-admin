import { ApiProperty } from '@nestjs/swagger';

export class OssInfo {
  @ApiProperty({ description: 'Oss id' })
  id: number;

  @ApiProperty({ description: '文件名' })
  name: string;

  @ApiProperty({ description: '扩展名' })
  extName: string;

  @ApiProperty({ description: '文件大小' })
  size: string;

  @ApiProperty({ description: '上次修改时间' })
  lastModified: string;

  @ApiProperty({ description: '类型' })
  type: string;

  @ApiProperty({ description: '地址' })
  url: string;
}
