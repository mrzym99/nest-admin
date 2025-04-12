import { Injectable } from '@nestjs/common';
import { RoleCreateDto, RoleQueryDto, RoleUpdateDto } from './dto/role.dto';
import { InjectEntityManager, InjectRepository } from '@nestjs/typeorm';
import { RoleEntity } from './role.entity';
import { EntityManager, In, Like, Not, Repository } from 'typeorm';

import { isEmpty, isNil } from 'lodash';
import { paginate } from '~/helper/pagination';
import { MenuEntity } from '../menu/menu.entity';
import { UserEntity } from '~/modules/user/user.entity';
import { ErrorEnum } from '~/constants/error.constant';
import { BusinessException } from '~/common/exceptions/biz.exception';

@Injectable()
export class RoleService {
  constructor(
    @InjectEntityManager()
    private readonly entityManager: EntityManager,
    @InjectRepository(RoleEntity)
    private readonly roleRepository: Repository<RoleEntity>,
    @InjectRepository(MenuEntity)
    private readonly menuRepository: Repository<MenuEntity>,
  ) {}

  async list({ currentPage, pageSize, status, name, value }: RoleQueryDto) {
    const queryBuilder = await this.roleRepository
      .createQueryBuilder('role')
      .where({
        ...(name && { name: Like(`%${name}%`) }),
        ...(value && { value: Like(`%${value}%`) }),
        ...(!isNil(status) && { status: In([status]) }),
      })
      .orderBy({ 'role.createdAt': 'ASC' });

    return await paginate<RoleEntity>(queryBuilder, { currentPage, pageSize });
  }

  async getAllEnableRoles() {
    const roles = this.roleRepository.findBy({ status: 1 });

    return roles;
  }

  async create({ menuIds, ...rest }: RoleCreateDto): Promise<void> {
    const role = await this.roleRepository.save({
      ...rest,
      menus:
        menuIds && menuIds.length
          ? await this.menuRepository.findBy({
              id: In(menuIds),
            })
          : [],
    });
    if (rest.default) {
      this.setDefaultRole(role.id);
    }
  }

  async update(
    id: number,
    { menuIds, ...roleUpdateDto }: RoleUpdateDto,
  ): Promise<void> {
    await this.roleRepository.update(id, roleUpdateDto);
    // 更新关联的菜单
    await this.entityManager.transaction(async (manager) => {
      const role = await this.roleRepository.findOne({
        where: {
          id,
        },
      });

      role.menus =
        menuIds && menuIds.length
          ? await this.menuRepository.findBy({
              id: In(menuIds),
            })
          : [];

      await manager.save(role);
    });

    if (roleUpdateDto.default) {
      await this.setDefaultRole(id);
    }
  }

  async default(id: number) {
    await this.roleRepository.update({ id }, { default: 1 });
    await this.setDefaultRole(id);
  }

  async setDefaultRole(id: number) {
    await this.roleRepository.update(
      {
        id: Not(id),
      },
      { default: 0 },
    );
  }

  async info(id: number) {
    const info = await this.roleRepository.findOne({
      where: {
        id,
      },
    });

    const menus = await this.menuRepository.find({
      where: {
        roles: { id },
      },
      select: ['id'],
    });

    return { ...info, menuIds: menus.map((item) => item.id) };
  }

  async validateRelateUser(roleId: number) {
    const exists = await this.roleRepository.exists({
      where: { users: { roles: { id: roleId } } },
    });

    if (exists) throw new BusinessException(ErrorEnum.ROLE_USED_BY_USER);
  }

  async getRoleIdsByUserId(userId: number): Promise<number[]> {
    const roles = await this.roleRepository.find({
      where: {
        users: { id: userId },
      },
    });
    if (!isEmpty(roles)) return roles.map((item) => item.id);

    return [];
  }

  async getRoleValuesByRoleIds(roleIds: number[]) {
    const roles = await this.roleRepository.find({
      where: {
        id: In(roleIds),
      },
    });
    if (!isEmpty(roles)) return roles.map((item) => item.value);

    return [];
  }

  async validateIsDefault(id: number) {
    const role = await this.roleRepository.findOne({
      where: {
        id,
      },
    });
    if (role.default) throw new BusinessException(ErrorEnum.ROLE_IS_DEFAULT);
  }

  async delete(id: number): Promise<void> {
    await this.roleRepository.delete(id);
  }
}
