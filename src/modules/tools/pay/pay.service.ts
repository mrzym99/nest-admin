import { Inject, Injectable, LoggerService } from '@nestjs/common';
import * as fs from 'node:fs';
import * as path from 'node:path';

import { IPayConfig, PayConfig } from '~/config/pay.config';
import { AlipaySdk, AlipaySdkSignType } from 'alipay-sdk';
import { PayDto, PayRefundDto } from './Pay.dto';
import { ALIPAY_SUCCESS_CODE } from '~/constants/response.constant';
import { BusinessException } from '~/common/exceptions/biz.exception';
import { ErrorEnum } from '~/constants/error.constant';
import { WINSTON_MODULE_NEST_PROVIDER } from 'nest-winston';

@Injectable()
export class PayService {
  private aliPaySdk: AlipaySdk;
  constructor(
    @Inject(PayConfig.KEY) private payConfig: IPayConfig,
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: LoggerService,
  ) {
    this.init();
  }

  async init() {
    const privateKey = await fs.readFileSync(
      path.join(__dirname, 'keys', 'private-key.pem'),
      'ascii',
    );

    const publicKey = await fs.readFileSync(
      path.join(__dirname, 'keys', 'public-key.pem'),
      'ascii',
    );

    if (!privateKey) {
      this.logger.error('[PAY]', '应用私钥不存在');
      return;
    }

    if (!publicKey) {
      this.logger.error('[PAY]', '支付宝公钥不存在');
      return;
    }

    this.aliPaySdk = new AlipaySdk({
      appId: this.payConfig.appId,
      signType: this.payConfig.signType as AlipaySdkSignType,
      gateway: this.payConfig.gateWay,
      privateKey: fs.readFileSync(
        path.join(__dirname, 'keys', 'private-key.pem'),
        'ascii',
      ),
      alipayPublicKey: fs.readFileSync(
        path.join(__dirname, 'keys', 'public-key.pem'),
        'ascii',
      ),
    });
  }

  async pay({ orderId, desc, price }: PayDto) {
    if (!this.aliPaySdk) {
      throw new BusinessException(ErrorEnum.PAY_NOT_INIT);
    }
    const content = {
      out_trade_no: orderId,
      product_code: 'FAST_INSTANT_TRADE_PAY',
      subject: desc,
      total_amount: price,
    };
    const url = await this.aliPaySdk.pageExec('alipay.trade.page.pay', 'GET', {
      bizContent: content,
    });

    return url;
  }

  async verify(oId: number) {
    if (!this.aliPaySdk) {
      throw new BusinessException(ErrorEnum.PAY_NOT_INIT);
    }
    const result = await this.aliPaySdk.exec('alipay.trade.query', {
      bizContent: {
        out_trade_no: oId,
      },
    });

    if (!result) {
      throw new BusinessException(ErrorEnum.PAY_NOT_FOUND);
    }

    return result.code === ALIPAY_SUCCESS_CODE;
  }

  async close(oId: number) {
    if (!this.aliPaySdk) {
      throw new BusinessException(ErrorEnum.PAY_NOT_INIT);
    }
    const result = await this.aliPaySdk.exec('alipay.trade.close', {
      bizContent: {
        out_trade_no: oId,
      },
    });

    if (!result) {
      throw new BusinessException(ErrorEnum.PAY_NOT_FOUND);
    }

    if (result.code !== ALIPAY_SUCCESS_CODE) {
      throw new BusinessException(`12002:${result.subMsg}`);
    }

    return true;
  }

  async refund({ orderId: oId, amount }: PayRefundDto) {
    if (!this.aliPaySdk) {
      throw new BusinessException(ErrorEnum.PAY_NOT_INIT);
    }
    const result = await this.aliPaySdk.exec('alipay.trade.refund', {
      bizContent: {
        out_trade_no: oId,
        refund_amount: amount,
      },
    });

    if (!result) {
      throw new BusinessException(ErrorEnum.PAY_NOT_FOUND);
    }

    if (result.code !== ALIPAY_SUCCESS_CODE) {
      throw new BusinessException(`12003:${result.subMsg}`);
    }

    return true;
  }
}
