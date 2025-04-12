import { Body, Controller, Get, Put, Req, UseGuards } from '@nestjs/common';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { JwtAuthGuard } from '../guards/jwt-auth.guard';
import { UserService } from '~/modules/user/user.service';
import { AuthService } from '../auth.service';
import { AllowAnon } from '../decorators/allow-anon.decorator';
import { AuthUser } from '../decorators/auth-user.decorator';
import { ApiResult } from '~/common/decorators/api-result.decorator';
import { AccountMenus } from '../dto/account.dto';
import { UserPasswordDto, UserProfileDto } from '~/modules/user/dto/user.dto';
import { Roles } from '../auth.constant';
import { TokenService } from '../services/token.service';
import { isEmpty } from 'class-validator';

@ApiTags('Auth - 账户模块')
@ApiSecurityAuth()
@UseGuards(JwtAuthGuard)
@Controller('auth/account')
export class AccountController {
  constructor(
    private readonly userService: UserService,
    private readonly authService: AuthService,
    private readonly tokenService: TokenService,
  ) {}

  @Get('profile')
  @ApiOperation({ summary: '获取账户详细信息' })
  @ApiResult({ type: UserProfileDto })
  @AllowAnon()
  async profile(@AuthUser() user: IAuthUser): Promise<UserProfileDto> {
    if (user.roles.includes(Roles.SUPER_ADMIN)) {
      return {
        id: -1,
        username: Roles.SUPER_ADMIN,
        nickName: '超级管理员',
        avatar:
          'https://myblogimgbucket.oss-cn-beijing.aliyuncs.com/WechatIMG434.jpg',
        roles: [Roles.SUPER_ADMIN],
        rolesName: ['超级管理员'],
        gender: 1,
      } as UserProfileDto;
    }
    return await this.userService.findUserProfile(user.uid);
  }

  @Get('logout')
  @ApiOperation({ summary: '账户退出登录' })
  async logout(
    @AuthUser() user: IAuthUser,
    @Req() req: ExpressRequest,
  ): Promise<void> {
    await this.authService.clearLoginStatus(req.accessToken, user);
  }

  @Get('menus')
  @ApiOperation({ summary: '获取账户菜单列表' })
  @ApiResult({ type: [AccountMenus] })
  async menu(@AuthUser() user: IAuthUser) {
    if (user.roles.includes(Roles.SUPER_ADMIN)) {
      return await this.authService.getAllMenus();
    } else {
      return await this.authService.getMenus(user.uid);
    }
  }

  @Get('permissions')
  @ApiOperation({ summary: '获取账户权限列表' })
  @ApiResult({ type: [String] })
  @AllowAnon()
  async permissions(@AuthUser() user: IAuthUser): Promise<string[]> {
    if (user.roles.includes(Roles.SUPER_ADMIN)) {
      return await this.authService.getAllPermissions();
    } else {
      return await this.authService.getPermissions(user.uid);
    }
  }

  @Put('profile')
  @ApiOperation({ summary: '更改账户信息' })
  @AllowAnon()
  async updateProfile(
    @AuthUser() user: IAuthUser,
    @Body() dto: UserProfileDto,
  ): Promise<void> {
    await this.userService.updateProfile(user.uid, dto);
  }

  @Put('password')
  @ApiOperation({ summary: '更改账户密码' })
  @AllowAnon()
  async updatePassword(
    @AuthUser() user: IAuthUser,
    @Body() dto: UserPasswordDto,
  ): Promise<void> {
    await this.userService.updatePassword(user.uid, dto);
    // 清楚当前用户 所有的登录信息
    const allAccessToken = await this.tokenService.findUserAccessToken(
      user.uid,
    );
    if (!isEmpty(allAccessToken)) {
      allAccessToken.forEach(async (token) => {
        await this.authService.clearLoginStatus(token.value, user);
      });
    }
  }
}
