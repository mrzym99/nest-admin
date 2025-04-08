import { Body, Controller, Headers, Post, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto, RefreshTokenDto, RegisterDto } from './dto/auth.dto';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { Ip } from '~/common/decorators/http.decorator';
import { Public } from './decorators/public.decorator';
import { MailerService } from '~/shared/mailer/mailer.service';
import { CaptchaService } from './services/captcha.service';
import { OnlineService } from '../system/monitor/online/online.service';
import { Throttle, ThrottlerGuard } from '@nestjs/throttler';

@Controller('auth')
@ApiTags('Auth - 用户登录注册')
@Public()
@UseGuards(ThrottlerGuard)
export class AuthController {
  constructor(
    private readonly authService: AuthService,
    private readonly mailerService: MailerService,
    private readonly captchaService: CaptchaService,
    private readonly onlineService: OnlineService,
  ) {}

  @Post('login')
  @ApiOperation({ summary: '用户登录' })
  @Throttle({ default: { limit: 5, ttl: 60 * 1000 } })
  async login(
    @Body() loginDto: LoginDto,
    @Ip() ip,
    @Headers('user-agent') userAgent,
  ) {
    const { captchaId, code } = loginDto;
    await this.captchaService.checkImgCaptcha(captchaId, code);
    return await this.authService.login(loginDto, ip, userAgent);
  }

  @Post('super/login')
  @ApiOperation({ summary: '超级管理员登录' })
  async superLogin(@Body() loginDto: LoginDto) {
    return await this.authService.superLogin(loginDto);
  }

  @Public()
  @Post('register')
  @ApiOperation({ summary: '用户注册' })
  async register(@Body() registerDto: RegisterDto) {
    await this.mailerService.checkCode(registerDto.email, registerDto.code);
    await this.authService.register(registerDto);
    await this.mailerService.deleteCode(registerDto.code);
  }

  @Post('refreshToken')
  @ApiOperation({ summary: '刷新token' })
  async refreshToken(
    @Body() refreshTokenDto: RefreshTokenDto,
    @Ip() ip: string,
    @Headers('user-agent') ua: string,
  ) {
    const { accessToken } = refreshTokenDto;
    const res = await this.authService.refreshToken(accessToken);
    await this.onlineService.addOnlineUser(res.access_token, ip, ua);
    return res;
  }
}
