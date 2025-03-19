import { forwardRef, Global, Module } from '@nestjs/common';
import { SseService } from './sse.service';
import { SseController } from './sse.controller';
import { OnlineModule } from '../system/online/online.module';

@Global()
@Module({
  imports: [forwardRef(() => OnlineModule)],
  controllers: [SseController],
  providers: [SseService],
  exports: [SseService],
})
export class SseModule {}
