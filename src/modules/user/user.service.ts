import { Inject, Injectable } from '@nestjs/common';
import { In, Like, Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import * as argon2 from 'argon2';

import { UserEntity } from './user.entity';
import {
  UserCreateDto,
  UserPasswordDto,
  UserProfileDto,
  UserQueryDto,
  UserResetPasswordDto,
  UserStatusDto,
  UserUpdateDto,
} from './dto/user.dto';
import { paginate } from '~/helper/pagination';
import { ProfileEntity } from './profile.entity';
import { Pagination } from '~/helper/pagination/pagination';
import { andWhereConditions, excludeFields, randomNickName } from '~/utils';
import {
  BizException,
  BusinessException,
} from '~/common/exceptions/biz.exception';
import { ErrorEnum } from '~/constants/error.constant';
import { RoleEntity } from '../system/role/role.entity';
import { DeptEntity } from '../system/dept/dept.entity';
import { InjectRedis } from '~/common/decorators/inject-redis.decorator';
import Redis from 'ioredis';
import {
  genAuthPermKey,
  genOnlineUserKey,
  genTokenBlacklistKey,
} from '~/helper/gen-redis-key';
import { AccessTokenEntity } from '../auth/entities/access-token.entity';
import { UserInfo } from './user.model';
import { isNil, isEmpty } from 'lodash';
import { AuthService } from '../auth/auth.service';
import { ISecurityConfig, SecurityConfig } from '~/config';
import { REG_PWD } from '~/constants/reg';

@Injectable()
export class UserService {
  constructor(
    @InjectRedis()
    private readonly redis: Redis,
    @InjectRepository(UserEntity)
    private readonly userRepository: Repository<UserEntity>,
    @InjectRepository(ProfileEntity)
    private readonly profileRepository: Repository<ProfileEntity>,
    @Inject(SecurityConfig.KEY)
    private readonly securityConfig: ISecurityConfig,
  ) { }

  async list({
    currentPage,
    pageSize,
    username,
    status,
    nickName,
    phone,
    email,
    deptIds,
    roleId,
  }: UserQueryDto): Promise<Pagination<UserInfo>> {
    const queryBuilder = await this.userRepository
      .createQueryBuilder('user')
      .leftJoinAndSelect('user.profile', 'profile')
      .leftJoinAndSelect('user.dept', 'dept')
      .leftJoinAndSelect('user.roles', 'roles')
      .where({
        ...(username && { username: Like(`%${username}%`) }),
        ...(!isNil(status) && { status }),
      })
      .orderBy({ 'user.createdAt': 'ASC' });

    // 连表查询时 使用 andWhere
    const conditions = {
      nickName: {
        field: 'profile.nick_name',
        value: nickName,
        operator: 'LIKE',
      },
      phone: {
        field: 'profile.phone',
        value: phone,
        operator: 'LIKE',
      },
      email: {
        field: 'profile.email',
        value: email,
        operator: 'LIKE',
      },
      deptIds: {
        field: 'dept.id',
        value: deptIds,
        operator: 'IN',
      },
      roleId: {
        field: 'roles.id',
        value: roleId,
        operator: '=',
      },
    };
    andWhereConditions(queryBuilder, conditions);

    const { list, total } = await paginate<UserEntity>(queryBuilder, {
      currentPage,
      pageSize,
    });

    return {
      currentPage,
      pageSize,
      // 对列表进行扁平化 方便前端使用
      list: list.map((user) => {
        user.dept = {
          name: user.dept.name,
          id: user.dept.id,
        } as DeptEntity;
        user.roles = user.roles.map((role) => {
          return {
            id: role.id,
            name: role.name,
            value: role.value,
          } as RoleEntity;
        });

        const profile = excludeFields(user.profile, [
          'id',
          'createdAt',
          'updatedAt',
        ]);

        const flatUser = { ...user, ...profile };
        delete flatUser.password;
        delete flatUser.profile;
        return flatUser;
      }),
      total,
    };
  }

  async exist(username: string): Promise<UserEntity> {
    const user = await this.userRepository.findOne({
      where: {
        username,
      },
    });

    const emailUser = await this.userRepository.findOne({
      where: {
        profile: {
          email: username,
        },
      },
      relations: ['profile'],
    });

    return user || emailUser;
  }

  async registerExist(username: string, email: string): Promise<void> {
    const user = await this.userRepository.findOne({
      where: {
        username,
      },
    });

    if (user) throw new BizException(ErrorEnum.USER_USERNAME_EXIST);

    const emailUser = await this.userRepository.findOne({
      where: {
        profile: {
          email: email,
        },
      },
      relations: ['profile'],
    });

    if (emailUser) throw new BizException(ErrorEnum.USER_EMAIL_EXIST);
  }

  // 获取用户所有的信息
  async findUserInfo(id: number): Promise<UserEntity> {
    return await this.userRepository.findOne({
      where: {
        id,
      },
      relations: ['profile', 'roles', 'dept'],
    });
  }

  // 获取用户详细信息
  async findUserProfile(id: number): Promise<UserProfileDto> {
    const user = await this.userRepository.findOne({
      where: {
        id,
      },
      relations: ['profile', 'dept', 'roles'],
    });

    // 排除一些基础属性
    const profile = excludeFields(user.profile, [
      'id',
      'createdAt',
      'updatedAt',
    ]);

    return {
      id: user.id,
      roles: user.roles.map((role) => role.value),
      rolesName: user.roles.map((role) => role.name),
      dept: user.dept.name,
      username: user.username,
      ...profile,
    };
  }

  async create({
    deptId,
    roleIds,
    ...user
  }: Partial<UserCreateDto>): Promise<void> {
    await this.userRepository.manager.transaction(async (manager) => {
      const defaultRole = await manager.findOne(RoleEntity, {
        where: {
          default: 1,
        },
      });
      const defaultDept = await manager.findOne(DeptEntity, {
        where: {
          default: 1,
        },
      });

      const createProfile = this.profileRepository.create({
        email: user.email,
        nickName: randomNickName(),
        avatar:
          'https://myblogimgbucket.oss-cn-beijing.aliyuncs.com/WechatIMG435.jpg',
      });
      const profile = await this.profileRepository.save(createProfile);
      const createUser = manager.create(UserEntity, {
        ...user,
        roles: !isEmpty(roleIds)
          ? await manager.find(RoleEntity, {
            where: {
              id: In(roleIds),
            },
          })
          : defaultRole
            ? [defaultRole]
            : [],
        dept: deptId
          ? await manager.findOne(DeptEntity, {
            where: {
              id: deptId,
            },
          })
          : defaultDept,
        profile: profile,
      });
      return await manager.save(createUser);
    });
  }

  async update(id: number, updateDto: UserUpdateDto): Promise<void> {
    await this.userRepository.manager.transaction(async (manager) => {
      const defaultRole = await manager.findOne(RoleEntity, {
        where: {
          default: 1,
        },
      });
      const defaultDept = await manager.findOne(DeptEntity, {
        where: {
          default: 1,
        },
      });
      const user = await this.findUserInfo(id);
      if (!user) {
        throw new BizException(ErrorEnum.USER_NOT_EXIST);
      }

      const isAdmin = await this.isAdmin(user.id);

      if (isAdmin && updateDto.status === 0) {
        throw new BusinessException(
          ErrorEnum.USER_NOT_ALLOWED_TO_DISABLE_ADMIN,
        );
      }

      const { roleIds, deptId, status, ...profile } = updateDto;

      user.status = isNil(status) ? user.status : status;

      user.roles = !isEmpty(roleIds)
        ? await manager.find(RoleEntity, {
          where: {
            id: In(roleIds),
          },
        })
        : defaultRole
          ? [defaultRole]
          : [];

      // 保存用户的部门
      user.dept = deptId
        ? await manager.findOne(DeptEntity, {
          where: {
            id: deptId,
          },
        })
        : defaultDept;

      await this.updateProfile(user.id, profile);
      await manager.save(user);

      if (user.status === 0) {
        await this.forbiddenUserByIds([user.id]);
      }
    });
  }

  async updatePassword(
    id: number,
    passwordDto: UserPasswordDto,
  ): Promise<void> {
    const { oldPassword, newPassword } = passwordDto;
    const user = await this.findUserInfo(id);
    if (!user) {
      throw new BizException(ErrorEnum.USER_NOT_EXIST);
    }

    if (!(await argon2.verify(user.password, oldPassword))) {
      throw new BizException(ErrorEnum.USER_PASSWORD_ERROR);
    }

    user.password = await argon2.hash(newPassword);

    await this.userRepository.save(user);
  }

  async resetPassword(id: number, dto: UserResetPasswordDto): Promise<void> {
    if (!REG_PWD.test(dto.password)) {
      throw new BizException(ErrorEnum.USER_PASSWORD_ERROR_RULE);
    }

    console.log(id, dto, '123aa')
    const user = await this.findUserInfo(id);
    if (!user) {
      throw new BizException(ErrorEnum.USER_NOT_EXIST);
    }

    user.password = await argon2.hash(dto.password);

    await this.userRepository.save(user);
  }

  async updateProfile(id: number, profile: UserProfileDto): Promise<void> {
    const user = await this.findUserInfo(id);
    if (!user) {
      throw new BizException(ErrorEnum.USER_NOT_EXIST);
    }
    this.profileRepository.merge(user.profile, profile);

    await this.profileRepository.save(user.profile);
  }

  async batchUpdateStatus({ ids, status }: UserStatusDto): Promise<void> {
    const users = await this.userRepository.find({
      where: {
        id: In(ids),
      },
      relations: ['roles'],
    });
    if (!isEmpty(users)) {
      users.forEach((user) => {
        if (user.roles.some((role) => role.value === 'admin')) {
          throw new BusinessException(
            ErrorEnum.USER_NOT_ALLOWED_TO_DISABLE_ADMIN,
          );
        }
      });

      await this.userRepository.update({ id: In(ids) }, { status });
      if (status === 0) {
        await this.forbiddenUserByIds(ids);
      }
    }
  }

  /**
   * 判断用户是否是管理员
   * @param id
   */
  async isAdmin(id: number) {
    const user = await this.findUserInfo(id);
    return user && user.roles.some((role) => role.value === 'admin');
  }

  /**
   * 禁用用户
   * @param uid 用户 id
   * @param accessToken token
   */
  async forbidden(uid: number, accessToken?: string): Promise<void> {
    // 移除用户的权限缓存
    await this.redis.del(genAuthPermKey(uid));
    // token 从表里删除
    if (accessToken) {
      const token = await AccessTokenEntity.findOne({
        where: {
          value: accessToken,
        },
        relations: ['refreshToken'],
      });
      if (token) {
        await this.redis.del(genOnlineUserKey(token.id));
        await token.refreshToken.remove();
        await token.remove();
      }
    }
  }

  /**
   * 通过传入用户 id 来禁用用户的token 从而让用户状态变化时 token 能及时被禁用
   * @param ids
   */
  async forbiddenUserByIds(ids: number[]) {
    const [list, _count] = await AccessTokenEntity.findAndCount({
      where: {
        user: {
          id: In(ids),
        },
      },
      relations: ['user'],
    });

    if (isEmpty(list)) return;

    list.forEach(async (item) => {
      await this.redis.set(
        genTokenBlacklistKey(item.value),
        item.value,
        'EX',
        this.securityConfig.jwtExpire,
      );
      await this.forbidden(item.user.id, item.value);
    });
  }
}
