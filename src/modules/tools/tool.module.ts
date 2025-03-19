import { Module } from '@nestjs/common';
import { UploadModule } from './upload/upload.module';
import { RouterModule } from '@nestjs/core';
import { StorageModule } from './storage/storage.module';
import { OssModule } from './oss/oss.module';
import { MailModule } from './mail/mail.module';

const modules = [UploadModule, StorageModule, MailModule, OssModule];

@Module({
  imports: [
    ...modules,
    RouterModule.register([
      {
        path: 'tools',
        module: ToolModule,
        children: [...modules],
      },
    ]),
  ],
  exports: [...modules],
})
export class ToolModule {}
