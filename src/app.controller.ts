import { Controller, Get } from '@nestjs/common';
import { Bypass } from './common/decorators/bypass.decorator';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Welcome to NestJS')
@Controller()
export class AppController {
  @Get()
  @Bypass()
  getHello(): string {
    return 'Welcome to NestJS!';
  }
}
