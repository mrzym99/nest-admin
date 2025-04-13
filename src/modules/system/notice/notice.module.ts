import { Global, Module } from '@nestjs/common';
import { NoticeService } from './notice.service';
import { NoticeController } from './notice.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { NoticeEntity } from './notice.entity';

@Global()
@Module({
  imports: [TypeOrmModule.forFeature([NoticeEntity])],
  controllers: [NoticeController],
  providers: [NoticeService],
  exports: [TypeOrmModule, NoticeService],
})
export class NoticeModule {}
