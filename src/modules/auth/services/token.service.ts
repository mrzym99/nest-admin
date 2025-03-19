import {
  Inject,
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { AccessTokenEntity } from '../entities/access-token.entity';
import { UserEntity } from '~/modules/user/user.entity';
import * as dayjs from 'dayjs';
import { ISecurityConfig, SecurityConfig } from '~/config';
import { MoreThan } from 'typeorm';
import { v4 as uuidv4 } from 'uuid';
import { RefreshTokenEntity } from '../entities/refresh-token.entity';
import { InjectRedis } from '~/common/decorators/inject-redis.decorator';
import Redis from 'ioredis';
import { genOnlineUserKey } from '~/helper/gen-redis-key';
import { RoleService } from '~/modules/system/role/role.service';
import { ErrorEnum } from '~/constants/error.constant';
import { UserService } from '~/modules/user/user.service';

@Injectable()
export class TokenService {
  constructor(
    private readonly jwtService: JwtService,
    @Inject(SecurityConfig.KEY)
    private readonly securityConfig: ISecurityConfig,
    @InjectRedis()
    private readonly redis: Redis,
    private readonly roleService: RoleService,
    private readonly userService: UserService,
  ) {}

  async findOne(value: string) {
    const token = await AccessTokenEntity.findOne({
      where: {
        value,
      },
      relations: ['user', 'refreshToken'],
    });
    return token;
  }

  /**
   * 获取用户所有的accessToken
   */
  async findUserAccessToken(uid: string) {
    return AccessTokenEntity.find({
      where: {
        user: {
          id: uid,
        },
        expiredAt: MoreThan(new Date()),
      },
    });
  }

  async refreshAccessToken(accessToken: AccessTokenEntity) {
    const { user, refreshToken } = accessToken;

    if (refreshToken) {
      if (dayjs().isAfter(refreshToken.expiredAt)) {
        this.removeRefreshToken(refreshToken.value);
        throw new UnauthorizedException(ErrorEnum.AUTH_R_TOKEN_INVALID);
      }

      const roleIds = await this.roleService.getRoleIdsByUserId(user.id);
      const roleValues = await this.roleService.getRoleValuesByRoleIds(roleIds);
      const { accessToken: newAccessToken } = await this.generateAccessToken(
        user.id,
        roleValues,
      );
      await this.removeAccessToken(accessToken);
      return {
        access_token: newAccessToken,
      };
    } else {
      throw new NotFoundException('refreshToken not found');
    }
  }

  /**
   * 生成 accessToken
   * @param uid 用户id
   * @param roles 角色列表
   */
  async generateAccessToken(uid: string, roles: string[]) {
    const payload: IAuthUser = {
      uid,
      roles,
    };

    const jwtSign = await this.generateJwtSign(payload);

    // 保存 accessToken 到数据库
    const accessToken = new AccessTokenEntity();
    accessToken.value = jwtSign;
    accessToken.user = {
      id: uid,
    } as UserEntity;
    accessToken.createdAt = new Date();
    accessToken.expiredAt = dayjs()
      .add(this.securityConfig.jwtExpire, 'second')
      .toDate();

    await accessToken.save();

    await this.generateRefreshToken(accessToken);

    return {
      accessToken: jwtSign,
      tokenId: accessToken.id,
    };
  }

  /**
   * 生成 refreshToken
   * @param accessToken
   */
  async generateRefreshToken(accessToken: AccessTokenEntity) {
    const refreshTokenPayload = {
      uuid: uuidv4(),
    };

    const refreshTokenSign = await this.jwtService.signAsync(
      refreshTokenPayload,
      {
        secret: this.securityConfig.refreshSecret,
      },
    );

    const refreshToken = new RefreshTokenEntity();
    refreshToken.value = refreshTokenSign;
    refreshToken.expiredAt = dayjs()
      .add(this.securityConfig.refreshExpire, 'second')
      .toDate();
    refreshToken.accessToken = accessToken;
    refreshToken.createdAt = new Date();

    await refreshToken.save();
  }

  /**
   * 生成超级管理员的token
   * @param uid
   * @param roles
   * @returns
   */
  async generateSuperAccessToken(uid: string, roles: string[]) {
    const payload: IAuthUser = {
      uid,
      roles,
    };

    const jwtSign = await this.generateJwtSign(payload);

    return {
      accessToken: jwtSign,
    };
  }

  /**
   * 生成JWT签名
   * @param payload
   */
  async generateJwtSign(payload: any) {
    const jwtSign = await this.jwtService.signAsync(payload);
    return jwtSign;
  }

  async checkAccessToken(token: string) {
    let valid = false;
    try {
      await this.verifyAccessToken(token);
      const one = await AccessTokenEntity.findOne({
        where: { value: token, expiredAt: MoreThan(new Date()) },
      });

      valid = !!one;
    } catch {
      valid = false;
    }

    return valid;
  }

  async verifyAccessToken(token: string) {
    const payload = await this.jwtService.verifyAsync(token);
    return payload;
  }

  /**
   * 移除accessToken
   * @param token
   */
  async removeAccessToken(accessToken: AccessTokenEntity) {
    if (accessToken) {
      await accessToken.refreshToken.remove();
      await accessToken.remove();
    }
  }

  /**
   * 移除 refreshToken
   */
  async removeRefreshToken(token: string) {
    const refreshToken = await RefreshTokenEntity.findOne({
      where: { value: token },
      relations: ['accessToken'],
    });

    if (refreshToken) {
      if (refreshToken.accessToken)
        this.redis.del(genOnlineUserKey(refreshToken.accessToken.id));
      await refreshToken.accessToken.remove();
      await refreshToken.remove();
    }
  }
}
