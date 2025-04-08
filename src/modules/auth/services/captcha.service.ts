import { Injectable } from '@nestjs/common';
import Redis from 'ioredis';
import { InjectRedis } from '~/common/decorators/inject-redis.decorator';
import { genCaptchaImgKey } from '~/helper/gen-redis-key';
import { CaptchaLogService } from '~/modules/system/monitor/log/services/captcha-log.service';
import { isEmpty } from 'lodash';
import { BusinessException } from '~/common/exceptions/biz.exception';
import { ErrorEnum } from '~/constants/error.constant';
import { ParameterService } from '~/modules/system/parameter/parameter.service';
import { ParameterKey } from '~/constants/parameter.constant';

@Injectable()
export class CaptchaService {
  constructor(
    @InjectRedis() private readonly redis: Redis,
    private readonly captchaLogService: CaptchaLogService,
    private readonly parametersService: ParameterService,
  ) {}

  async checkImgCaptcha(id: string, code: string): Promise<void> {
    const needVerify = await this.parametersService.findOneByKey(
      ParameterKey.LOGIN_CAPTCHA_ENABLE,
    );
    // 参数设置里可设置 是否需要验证码验证
    if (needVerify === 'true') {
      const result = await this.redis.get(genCaptchaImgKey(id));
      if (isEmpty(result) || code.toLowerCase() !== result.toLowerCase()) {
        throw new BusinessException(ErrorEnum.AUTH_CAPTCHA_ERROR);
      }

      // 删除验证码
      await this.redis.del(genCaptchaImgKey(id));
    }
  }

  async createCaptchaLog(code: string): Promise<void> {
    await this.captchaLogService.create('', code, 'captcha');
  }
}
