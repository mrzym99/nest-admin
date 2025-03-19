import { Module } from '@nestjs/common';
import { StorageService } from './storage.service';
import { StorageController } from './storage.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Storage } from './storage.entity';
import { UserEntity } from '~/modules/user/user.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Storage, UserEntity])],
  controllers: [StorageController],
  providers: [StorageService],
  exports: [TypeOrmModule, StorageService],
})
export class StorageModule {}
