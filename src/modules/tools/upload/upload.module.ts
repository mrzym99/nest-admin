import { forwardRef, Module } from '@nestjs/common';
import { UploadService } from './upload.service';
import { UploadController } from './upload.controller';
import { StorageModule } from '../storage/storage.module';
import { OssModule } from '../oss/oss.module';

@Module({
  imports: [forwardRef(() => StorageModule), forwardRef(() => OssModule)],
  controllers: [UploadController],
  providers: [UploadService],
  exports: [UploadService],
})
export class UploadModule {}
