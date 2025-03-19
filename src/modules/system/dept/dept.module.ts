import { Module } from '@nestjs/common';
import { DeptService } from './dept.service';
import { DeptController } from './dept.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DeptEntity } from './dept.entity';
import { UserModule } from '~/modules/user/user.module';

@Module({
  imports: [TypeOrmModule.forFeature([DeptEntity]), UserModule],
  controllers: [DeptController],
  providers: [DeptService, TypeOrmModule],
})
export class DeptModule {}
