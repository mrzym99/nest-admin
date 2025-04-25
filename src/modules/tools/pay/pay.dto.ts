import { ApiProperty } from '@nestjs/swagger';
import { IsNumber, IsString } from 'class-validator';
import { ToNumber } from '~/common/decorators/transform.decorator';

/**
 * 支付订单
 */
export class PayDto {
  @ApiProperty({ description: '支付订单id' })
  @IsNumber()
  @ToNumber()
  orderId: string;

  @ApiProperty({ description: '标题' })
  @ToNumber()
  @IsNumber()
  price: number;

  @ApiProperty({ description: '描述' })
  @IsString()
  desc: string;
}


/**
 * 订单退款
 */
export class PayRefundDto {
  @ApiProperty({ description: '支付订单id' })
  @IsNumber()
  @ToNumber()
  orderId: string;

  @ApiProperty({ description: '退款金额' })
  @ToNumber()
  @IsNumber()
  amount: number;
}
