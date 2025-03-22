import { forwardRef, Module } from '@nestjs/common';
import { DictTypeService } from './dict-type.service';
import { DictTypeController } from './dict-type.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DictTypeEntity } from './dict-type.entity';
import { DictItemModule } from '../item/dict-item.module';

@Module({
  imports: [TypeOrmModule.forFeature([DictTypeEntity]), DictItemModule],
  controllers: [DictTypeController],
  providers: [DictTypeService],
  exports: [DictTypeService, TypeOrmModule],
})
export class DictTypeModule {}
