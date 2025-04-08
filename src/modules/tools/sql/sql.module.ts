import { Module } from '@nestjs/common';
import { SqlController } from './sql.controller';
import { SqlService } from './sql.service';

@Module({
  controllers: [SqlController],
  providers: [SqlService],
  exports: [SqlService],
})
export class SqlModule {}
