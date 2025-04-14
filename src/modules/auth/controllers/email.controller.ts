import { Body, Controller, Post, UseGuards } from '@nestjs/common';
import { ApiOperation, ApiProperty, ApiTags } from '@nestjs/swagger';
import { Throttle, ThrottlerGuard } from '@nestjs/throttler';
import { CaptchaLogService } from '~/modules/system/monitor/log/services/captcha-log.service';
import { Public } from '../decorators/public.decorator';
import { Ip } from '~/common/decorators/http.decorator';
import { EmailSendCodeDto } from '../dto/captcha.dto';
import { MailerService } from '~/shared/mailer/mailer.service';
import { Idempotence } from '~/common/decorators/idempotence.decorator';

@ApiTags('Auth - Email模块')
@Controller('auth/email')
@UseGuards(ThrottlerGuard)
export class EmailController {
  constructor(
    private readonly mailerSerice: MailerService,
    private readonly captchaLogService: CaptchaLogService,
  ) {}

  @Post('send')
  @ApiOperation({ summary: '发送验证码' })
  @Public()
  @Throttle({ default: { limit: 1, ttl: 60 * 1000 } })
  @Idempotence({
    errorMessage: '请一分钟后再发送验证码',
  })
  async sendCode(
    @Body() dto: EmailSendCodeDto,
    @Ip() ip: string,
  ): Promise<void> {
    const { email } = dto;
    await this.mailerSerice.checkLimit(email, ip);
    const { code } = await this.mailerSerice.sendVerificationCode(email);
    await this.mailerSerice.log(email, code, ip);
    await this.captchaLogService.create(email, code, 'email');
  }
}
