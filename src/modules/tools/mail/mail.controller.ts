import { Body, Controller, Post, UseGuards } from '@nestjs/common';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { MailSendDto } from './mail.dto';
import { MailerService } from '~/shared/mailer/mailer.service';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';
import { Throttle, ThrottlerGuard } from '@nestjs/throttler';

export const permissions = definePermission('tool:mail', {
  SEND: 'send',
} as const);

@ApiTags('Tools - 邮件模块')
@ApiSecurityAuth()
@Controller('mail')
@UseGuards(ThrottlerGuard)
export class MailController {
  constructor(private readonly mailService: MailerService) {}

  @Post('send')
  @ApiOperation({ summary: '发送邮件' })
  @Perm(permissions.SEND)
  @Throttle({ default: { limit: 5, ttl: 30 * 60 * 1000 } })
  async send(@Body() dto: MailSendDto): Promise<void> {
    const { to, subject, content } = dto;
    await this.mailService.send(to, subject, content, 'html');
  }
}
