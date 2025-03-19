import { Injectable } from '@nestjs/common';
import Redis from 'ioredis';
import { InjectRedis } from '~/common/decorators/inject-redis.decorator';
import { genCaptchaImgKey } from '~/helper/gen-redis-key';
import { CaptchaLogService } from '~/modules/system/log/services/captcha-log.service';
import { isEmpty } from 'lodash';
import { BusinessException } from '~/common/exceptions/biz.exception';
import { ErrorEnum } from '~/constants/error.constant';
import { AllConfigKeyAndPath, IAppConfig } from '~/config';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class CaptchaService {
  constructor(
    @InjectRedis() private readonly redis: Redis,
    private readonly captchaLogService: CaptchaLogService,
    private readonly configService: ConfigService<AllConfigKeyAndPath>,
  ) {}

  async checkImgCaptcha(id: string, code: string): Promise<void> {
    // 演示模式下不开启验证码验证
    if (this.configService.get<IAppConfig>('app').mode === 'demo') {
      return;
    }

    const result = await this.redis.get(genCaptchaImgKey(id));
    if (isEmpty(result) || code.toLowerCase() !== result.toLowerCase()) {
      throw new BusinessException(ErrorEnum.AUTH_CAPTCHA_ERROR);
    }

    // 删除验证码
    await this.redis.del(genCaptchaImgKey(id));
  }

  async createCaptchaLog(code: string): Promise<void> {
    await this.captchaLogService.create('', code, 'captcha');
  }
}
