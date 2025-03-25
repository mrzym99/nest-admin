import { ApiProperty } from '@nestjs/swagger';
import { IsArray } from 'class-validator';

export class DeleteDto {
  @ApiProperty({ description: '删除id列表' })
  @IsArray()
  ids: string[];
}

export class DeleteFileDto {
  @ApiProperty({ description: '删除文件列表' })
  @IsArray()
  fileNames: string[];
}
