import { Module } from '@nestjs/common';
import { OssController } from './oss.controller';
import { AliOssService } from './alioss.service';

@Module({
  imports: [],
  controllers: [OssController],
  providers: [AliOssService],
  exports: [AliOssService],
})
export class OssModule {}
