import {
  Body,
  Controller,
  Param,
  Post,
  UseGuards,
  Headers,
  Get,
  Query,
} from '@nestjs/common';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { Throttle, ThrottlerGuard } from '@nestjs/throttler';
import { Public } from '../decorators/public.decorator';
import { Ip } from '~/common/decorators/http.decorator';
import { ThirdLoginService } from '../services/third-login.service';
import {
  ThirdLoginCheckDto,
  ThirdLoginCodeDto,
  ThirdLoginDto,
} from '../dto/third-login.dto';

@ApiTags('Auth - ThirdLogin模块')
@Controller('auth/third-login')
@UseGuards(ThrottlerGuard)
export class ThirdLoginController {
  constructor(private readonly thirdLoginService: ThirdLoginService) {}

  @Get('url/:type')
  @ApiOperation({ summary: '获取三方登录跳转的url' })
  @Public()
  @Throttle({ default: { limit: 5, ttl: 60 * 1000 } })
  async url(@Param('type') type: 'github'): Promise<string> {
    return await this.thirdLoginService.returnUrl(type);
  }

  @Get('getTypeAndToken')
  @ApiOperation({
    summary: '根据三方登录返回的code 获取 token_type 和 access_token',
  })
  @Public()
  @Throttle({ default: { limit: 5, ttl: 60 * 1000 } })
  async getTypeAndToken(@Query() dto: ThirdLoginCodeDto) {
    const { type, code } = dto;
    return await this.thirdLoginService.getTokenAndTokenType(type, code);
  }

  @Get('checkRegister')
  @ApiOperation({ summary: '判断用户是否已经注册' })
  @Public()
  @Throttle({ default: { limit: 5, ttl: 60 * 1000 } })
  async checkRegister(@Query() dto: ThirdLoginCheckDto) {
    const { type, token_type, access_token } = dto;
    return await this.thirdLoginService.hasRegistered(
      type,
      token_type,
      access_token,
    );
  }

  @Post('login')
  @ApiOperation({ summary: '三方登录' })
  @Public()
  @Throttle({ default: { limit: 5, ttl: 60 * 1000 } })
  async login(
    @Body() dto: ThirdLoginDto,
    @Ip() ip: string,
    @Headers('user-agent') userAgent: string,
  ) {
    return await this.thirdLoginService.login(dto, ip, userAgent);
  }
}
