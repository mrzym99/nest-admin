import { Body, Controller, Post, UseGuards } from '@nestjs/common';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { PayDto, PayRefundDto } from './Pay.dto';
import { Throttle, ThrottlerGuard } from '@nestjs/throttler';
import { PayService } from './pay.service';
import { Public } from '~/modules/auth/decorators/public.decorator';
import { ParamId } from '~/common/decorators/param-id.decorator';

@ApiTags('Tools - 支付')
@ApiSecurityAuth()
@Controller('pay')
@UseGuards(ThrottlerGuard)
export class PayController {
  constructor(private readonly payService: PayService) {}

  @Post('pay')
  @ApiOperation({ summary: '支付订单' })
  @Public()
  @Throttle({ default: { limit: 5, ttl: 60 * 1000 } })
  async pay(@Body() dto: PayDto): Promise<string> {
    return await this.payService.pay(dto);
  }

  @Post('verify/:id')
  @ApiOperation({ summary: '校验订单是否支付' })
  @Public()
  @Throttle({ default: { limit: 5, ttl: 60 * 1000 } })
  async verify(@ParamId() id: number): Promise<boolean> {
    return await this.payService.verify(id);
  }

  @Post('refund')
  @ApiOperation({ summary: '订单退款' })
  @Public()
  async refund(@Body() dto: PayRefundDto): Promise<boolean> {
    return await this.payService.refund(dto);
  }

  @Post('close/:id')
  @ApiOperation({ summary: '关闭订单' })
  @Public()
  async close(@ParamId() id: number): Promise<boolean> {
    return await this.payService.close(id);
  }
}
