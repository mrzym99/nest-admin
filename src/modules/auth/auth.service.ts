import { Inject, Injectable, NotFoundException } from '@nestjs/common';
import { LoginDto, RegisterDto } from './dto/auth.dto';
import { UserService } from '../user/user.service';
import { BizException } from '~/common/exceptions/biz.exception';
import * as argon2 from 'argon2';
import { TokenService } from './services/token.service';
import { ErrorEnum } from '~/constants/error.constant';
import { LoginLogService } from '../system/monitor/log/services/login-log.service';
import { InjectRedis } from '~/common/decorators/inject-redis.decorator';
import Redis from 'ioredis';
import {
  genAuthPermKey,
  genAuthTokenKey,
  genForcedOfflineKey,
  genTokenBlacklistKey,
} from '~/helper/gen-redis-key';
import { MenuService } from '../system/menu/menu.service';
import { RoleService } from '../system/role/role.service';
import {
  AppConfig,
  IAppConfig,
  ISecurityConfig,
  SecurityConfig,
} from '~/config';
import { Roles } from './auth.constant';
import { UserEntity } from '../user/user.entity';

@Injectable()
export class AuthService {
  constructor(
    private readonly tokenService: TokenService,
    private readonly roleService: RoleService,
    private readonly userService: UserService,
    private readonly menuService: MenuService,
    private readonly LoginLogService: LoginLogService,
    @Inject(SecurityConfig.KEY)
    private readonly securityConfig: ISecurityConfig,
    @Inject(AppConfig.KEY)
    private readonly appConfig: IAppConfig,
    @InjectRedis() private readonly redis: Redis,
  ) {}

  async refreshToken(value: string) {
    const accessToken = await this.tokenService.findOne(value);
    if (accessToken) {
      return await this.tokenService.refreshAccessToken(accessToken);
    } else {
      throw new NotFoundException('accessToken not found');
    }
  }

  /**
   *  用户登录
   * @param user 用户信息
   * @param ip 用户ip
   * @param userAgent 用户代理信息
   * @returns access_token
   */
  async login(user: LoginDto, ip: string, userAgent: string) {
    const { username, password } = user;

    const findOne = await this.userService.exist(username);
    await this.checkUserCanLogin(findOne);

    if (!(await argon2.verify(findOne.password, password))) {
      throw new BizException(ErrorEnum.USER_NAME_OR_PASSWORD_ERROR);
    }

    return await this.loginDetails(findOne.id, ip, userAgent);
  }

  /**
   *  用户验证码登录
   * @param user 用户信息
   * @param ip 用户ip
   * @param userAgent 用户代理信息
   * @returns access_token
   */
  async codeLogin(email: string, ip: string, userAgent: string) {
    const findOne = await this.userService.findUserInfoByEmail(email);
    await this.checkUserCanLogin(findOne);
    return await this.loginDetails(findOne.id, ip, userAgent);
  }

  async checkUserCanLogin(user: UserEntity) {
    if (!user) {
      throw new BizException(ErrorEnum.USER_NOT_EXIST);
    }

    if (user.status === 0) {
      throw new BizException(ErrorEnum.USER_BANNED);
    }

    if (await this.redis.get(genForcedOfflineKey(user.id))) {
      throw new BizException(ErrorEnum.USER_FORCED_OFFLINE);
    }
  }

  async loginDetails(uid: number, ip: string, userAgent: string) {
    const roleIds = await this.roleService.getRoleIdsByUserId(uid);
    const roles = await this.roleService.getRoleValuesByRoleIds(roleIds);

    const { accessToken } = await this.tokenService.generateAccessToken(
      uid,
      roles,
    );

    // 缓存用户的权限
    const permissions = await this.menuService.getPermissions(uid);

    await this.setPermissionsCache(uid, permissions);

    // 给用户登录打上日志
    await this.LoginLogService.create({
      userId: uid,
      ip,
      userAgent,
    });

    return {
      access_token: accessToken,
    };
  }

  /**
   * 用户注册
   * @param user 用户信息
   */
  async register(user: RegisterDto): Promise<void> {
    const { password, email, username } = user;

    // 校验用户名和邮箱是否已经存在
    await this.userService.checkUserExist(username, email);

    user.username = username || email;
    user.password = await argon2.hash(password);

    await this.userService.create(user, true);
  }

  async clearLoginStatus(accessToken: string, user?: IAuthUser): Promise<void> {
    if (!user) {
      user = await this.tokenService.verifyAccessToken(accessToken);
    }
    const exp = user.exp
      ? (user.exp - Date.now() / 1000).toFixed(0)
      : this.securityConfig.jwtExpire;
    // 把 token 放入黑名单 设置剩下的过期时间 不能让这个 token 继续使用
    await this.redis.set(
      genTokenBlacklistKey(accessToken),
      accessToken,
      'EX',
      exp,
    );

    // 如果是多设备登录，则删除 token，否则移除这个用户的权限，这样就得重新登录才有权限了
    if (this.appConfig.multiDeviceLogin) {
      const accessTokenEntity = await this.tokenService.findOne(accessToken);
      await this.tokenService.removeAccessToken(accessTokenEntity);
    } else {
      await this.userService.forbidden(user.uid, accessToken);
    }
  }

  /**
   * 获取用户菜单
   * @param uid 用户id
   */
  async getMenus(uid: number) {
    return await this.menuService.getMenusByUserId(uid);
  }

  async getAllMenus() {
    return await this.menuService.getAllMenus();
  }

  /**
   * 获取用户权限
   * @param uid 用户id
   */
  async getPermissions(uid: number): Promise<string[]> {
    return this.menuService.getPermissions(uid);
  }

  async getAllPermissions() {
    return this.menuService.getAllPermissions();
  }

  /**
   * 缓存用户权限
   * @param uid 用户 id
   * @param permissions  用户权限
   */
  async setPermissionsCache(uid: number, permissions: string[]): Promise<void> {
    await this.redis.set(genAuthPermKey(uid), JSON.stringify(permissions));
  }

  /**
   * 获取权限缓存
   * @param uid 用户id
   */
  async getPermissionsCache(uid: number): Promise<string[]> {
    const permissions = await this.redis.get(genAuthPermKey(uid));
    return permissions ? JSON.parse(permissions) : [];
  }

  async getTokenByUid(uid: number): Promise<string> {
    return this.redis.get(genAuthTokenKey(uid));
  }
}
