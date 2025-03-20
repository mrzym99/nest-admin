import { Module } from '@nestjs/common';
import { OssController } from './oss.controller';
import { AliOssService } from './alioss.service';
import { QClouldOssService } from './qcloudoss.service';

@Module({
  imports: [],
  controllers: [OssController],
  providers: [AliOssService, QClouldOssService],
  exports: [AliOssService, QClouldOssService],
})
export class OssModule {}
