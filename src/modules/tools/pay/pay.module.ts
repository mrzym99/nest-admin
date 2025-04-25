
import { Module } from '@nestjs/common';
import { PayService } from './pay.service';
import { PayController } from './pay.controller';

const providers = [PayService];

@Module({
  controllers: [PayController],
  providers,
  exports: providers,
})
export class PayModule {}
