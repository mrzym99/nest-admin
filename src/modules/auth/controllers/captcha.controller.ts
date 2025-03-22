import { Controller, Get, Query, UseGuards } from '@nestjs/common';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import Redis from 'ioredis';
import { ApiResult } from '~/common/decorators/api-result.decorator';
import { InjectRedis } from '~/common/decorators/inject-redis.decorator';
import { ImageCaptchaDto } from '../dto/captcha.dto';
import * as svgCaptcha from 'svg-captcha';
import { genCaptchaImgKey } from '~/helper/gen-redis-key';
import { ImageCaptcha } from '../models/auth.model';
import { Public } from '../decorators/public.decorator';
import { CaptchaService } from '../services/captcha.service';
import { v4 as uuidv4 } from 'uuid';
import { Throttle, ThrottlerGuard } from '@nestjs/throttler';

@ApiTags('Auth - Captcha模块')
@Controller('auth/captcha')
@UseGuards(ThrottlerGuard)
export class CaptchaController {
  constructor(
    @InjectRedis() private readonly redis: Redis,
    private readonly captchaService: CaptchaService,
  ) {}

  @Get('img')
  @ApiOperation({
    summary: '获取验证码',
  })
  @Public()
  @ApiResult({ type: ImageCaptcha })
  @Throttle({ default: { limit: 5, ttl: 60 * 1000 } })
  async captcha(@Query() dto: ImageCaptchaDto): Promise<ImageCaptcha> {
    const { width = 100, height = 50 } = dto;
    const svg = svgCaptcha.create({
      size: 4,
      color: true,
      ignoreChars: '0o1il',
      width,
      height,
      noise: 1,
      background: '#fcfcfc',
    });

    const result = {
      img: `data:image/svg+xml;base64,${Buffer.from(svg.data).toString(
        'base64',
      )}`,
      id: uuidv4(),
    };
    // 验证码五分钟过期
    await this.redis.set(genCaptchaImgKey(result.id), svg.text, 'EX', 60 * 5);
    await this.captchaService.createCaptchaLog(svg.text);

    return result;
  }
}
