import { Module } from '@nestjs/common';
import { DictItemController } from './dict-item.controller';
import { DictItemService } from './dict-item.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DictItemEntity } from './dict-item.entity';

@Module({
  imports: [TypeOrmModule.forFeature([DictItemEntity])],
  controllers: [DictItemController],
  providers: [DictItemService],
  exports: [DictItemService, TypeOrmModule],
})
export class DictItemModule {}
