import { Inject, Injectable } from '@nestjs/common';

import { MailerService as NestMailerService } from '@nestjs-modules/mailer';
import * as dayjs from 'dayjs';

import Redis from 'ioredis';

import { InjectRedis } from '~/common/decorators/inject-redis.decorator';
import { BusinessException } from '~/common/exceptions/biz.exception';
import { IMailerConfig, MailerConfig } from '~/config';
import { randomValue } from '~/utils';
import { ErrorEnum } from '~/constants/error.constant';

@Injectable()
export class MailerService {
  constructor(
    @Inject(MailerConfig.KEY) private mailerConfig: IMailerConfig,
    @InjectRedis() private redis: Redis,
    private mailerService: NestMailerService,
  ) {}

  async log(to: string, code: string, ip: string) {
    const getRemainTime = () => {
      const now = dayjs();
      return now.endOf('day').diff(now, 'second');
    };

    await this.redis.set(`captcha:${to}`, code, 'EX', 60 * 5);

    // 一分钟内一个 ip 只能发送一次
    await this.redis.set(`ip:${ip}:send:limit`, 1, 'EX', 60);
    await this.redis.set(`captcha:${to}:limit`, 1, 'EX', 60);
    // 发送一次就 + 1
    await this.redis
      .multi()
      .incr(`captcha:${to}:limit-day`)
      .expire(`captcha:${to}:limit-day`, getRemainTime())
      .exec();
    await this.redis
      .multi()
      .incr(`ip:${ip}:send:limit-day`)
      .expire(`ip:${ip}:send:limit-day`, getRemainTime())
      .exec();
  }

  async checkCode(to, code) {
    const ret = await this.redis.get(`captcha:${to}`);

    if (!ret) throw new BusinessException(ErrorEnum.VERIFICATION_CODE_USED);

    if (ret !== code)
      throw new BusinessException(ErrorEnum.VERIFICATION_CODE_ERROR);
  }

  async deleteCode(to) {
    await this.redis.del(`captcha:${to}`);
  }

  async checkLimit(to, ip) {
    const LIMIT_TIME = 5;

    // ip限制
    const ipLimit = await this.redis.get(`ip:${ip}:send:limit`);
    if (ipLimit) throw new BusinessException(ErrorEnum.TOO_MANY_REQUESTS);

    // 1分钟最多接收1条
    const limit = await this.redis.get(`captcha:${to}:limit`);
    if (limit) throw new BusinessException(ErrorEnum.TOO_MANY_REQUESTS);

    // 1天一个邮箱最多接收5条
    let limitCountOfDay: string | number = await this.redis.get(
      `captcha:${to}:limit-day`,
    );
    limitCountOfDay = limitCountOfDay ? Number(limitCountOfDay) : 0;
    if (limitCountOfDay > LIMIT_TIME) {
      throw new BusinessException(ErrorEnum.VERIFICATION_CODE_SEND_LIMIT);
    }

    // 1天一个ip最多发送5条
    let ipLimitCountOfDay: string | number = await this.redis.get(
      `ip:${ip}:send:limit-day`,
    );
    ipLimitCountOfDay = ipLimitCountOfDay ? Number(ipLimitCountOfDay) : 0;
    if (ipLimitCountOfDay > LIMIT_TIME) {
      throw new BusinessException(ErrorEnum.VERIFICATION_CODE_SEND_LIMIT);
    }
  }

  async send(
    to,
    subject,
    content: string,
    type: 'text' | 'html' = 'text',
  ): Promise<any> {
    if (type === 'text') {
      return this.mailerService.sendMail({
        to,
        subject,
        text: content,
      });
    } else {
      return this.mailerService.sendMail({
        to,
        subject,
        html: content,
      });
    }
  }

  async sendVerificationCode(to, code = randomValue(4, '1234567890')) {
    const subject = `[${this.mailerConfig.auth.from}] 验证码`;

    try {
      await this.mailerService.sendMail({
        to,
        subject,
        template: './verification-code-zh',
        context: {
          code,
        },
      });
    } catch (error) {
      console.log(error);
      throw new BusinessException(ErrorEnum.VERIFICATION_CODE_SEND_FAIL);
    }

    return {
      to,
      code,
    };
  }

  // async sendUserConfirmation(user: UserEntity, token: string) {
  //   const url = `example.com/auth/confirm?token=${token}`
  //   await this.mailerService.sendMail({
  //     to: user.email,
  //     subject: 'Confirm your Email',
  //     template: './confirmation',
  //     context: {
  //       name: user.name,
  //       url,
  //     },
  //   })
  // }
}
