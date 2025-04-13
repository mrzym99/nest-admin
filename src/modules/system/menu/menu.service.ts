import { Injectable } from '@nestjs/common';
import {
  MenuCreateDto,
  MenuQueryDto,
  MenuStatusDto,
  MenuType,
  MenuUpdateDto,
} from './dto/create-menu.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { MenuEntity } from './menu.entity';
import { In, Like, Repository } from 'typeorm';
import { isNil, isEmpty, uniq } from 'lodash';
import { generateMenu, generateRoutes } from '~/utils';
import { BizException } from '~/common/exceptions/biz.exception';
import { ErrorEnum } from '~/constants/error.constant';
import { RoleEntity } from '../role/role.entity';
import { RoleService } from '../role/role.service';
import { InjectRedis } from '~/common/decorators/inject-redis.decorator';
import Redis from 'ioredis';
import { genAuthPermKey, genOnlineUserKey } from '~/helper/gen-redis-key';
import { OnlineUser } from '../monitor/online/online.model';
import { SseService } from '~/modules/sse/sse.service';
import { Pagination } from '~/helper/pagination/pagination';
import { createPaginationObject } from '~/helper/pagination/create-pagination';

@Injectable()
export class MenuService {
  constructor(
    @InjectRedis() private readonly redis: Redis,
    @InjectRepository(MenuEntity)
    private readonly menuRepository: Repository<MenuEntity>,
    @InjectRepository(RoleEntity)
    private readonly roleRepository: Repository<RoleEntity>,
    private readonly sseService: SseService,
    private readonly roleService: RoleService,
  ) {}

  /**
   * 创建菜单
   * @param MenuCreateDto
   */
  async create(MenuCreateDto: MenuCreateDto): Promise<void> {
    await this.menuRepository.save(MenuCreateDto);
  }

  /**
   * 获取菜单列表
   * @param MenuQueryDto
   */
  async list({
    title,
    name,
    path,
    permission,
    component,
    status,
  }: MenuQueryDto): Promise<Pagination<MenuEntity[]>> {
    const menus = await this.menuRepository.find({
      where: {
        ...(title && { title: Like(`%${title}%`) }),
        ...(name && { name: Like(`%${name}%`) }),
        ...(path && { path: Like(`%${path}%`) }),
        ...(permission && { permission: Like(`%${permission}%`) }),
        ...(component && { component: Like(`%${component}%`) }),
        ...(!isNil(status) ? { status } : null),
      },
      order: {
        order: 'ASC',
      },
    });
    const genMenus = generateMenu(menus);

    const menuList = isEmpty(genMenus) ? menus : genMenus;

    return createPaginationObject({
      list: menuList,
      currentPage: 1,
      pageSize: menuList.length,
      total: menuList.length,
    });
  }

  /**
   * 获取菜单树
   */
  async listMenuTree(): Promise<MenuEntity[]> {
    const menus = await this.menuRepository.find({
      where: {
        ...{ status: 1 },
      },
      order: {
        order: 'ASC',
      },
    });
    const menuList = generateMenu(menus);

    return menuList;
  }

  /**
   * 获取菜单详情
   * @param id
   */
  async getMenuItemInfo(id: number): Promise<MenuEntity> {
    return await this.menuRepository.findOneBy({ id });
  }

  /**
   * 获取菜单详情 和 菜单父级信息
   * @param id
   */
  async getMenuItemAndParentInfo(id: number) {
    const menu = await this.getMenuItemInfo(id);
    let parentMenu;
    if (menu && menu.parentId) {
      parentMenu = await this.getMenuItemInfo(menu.parentId);
    }
    return {
      ...menu,
      parent: parentMenu,
    };
  }

  /**
   * 验证菜单是否重复
   * @param dto
   * @param id
   */
  async validateRepeat(
    dto: MenuCreateDto | MenuUpdateDto,
    id?: number,
  ): Promise<void | never> {
    if (id) {
      const one = await this.menuRepository.findOne({
        where: {
          parentId: dto.parentId,
          ...(dto.type && { type: dto.type }),
          ...(dto.name && { name: dto.name }),
          ...(dto.path && { path: dto.path }),
          ...(dto.permission && { permission: dto.permission }),
        },
      });

      // 有 id 时需要判断是不是当前菜单未修改
      if (one && one.id !== Number(id))
        throw new BizException(ErrorEnum.MENU_EXIST);
    } else {
      const one = await this.menuRepository.findOne({
        where: {
          parentId: dto.parentId,
          ...(dto.title && { title: dto.title }),
          ...(dto.i18nKey && { i18nKey: dto.i18nKey }),
          ...(dto.type && { type: dto.type }),
          ...(dto.name && { name: dto.name }),
          ...(dto.path && { path: dto.path }),
          ...(dto.permission && { permission: dto.permission }),
          ...(dto.component && { component: dto.component }),
          ...(dto.isExt && { isExt: dto.isExt }),
        },
      });
      // 新建的时候看有没有相同的菜单
      if (one) throw new BizException(ErrorEnum.MENU_EXIST);
    }
  }

  /**
   * 验证菜单是否正确
   * @param dto
   */
  async validate(dto: MenuUpdateDto): Promise<void | never> {
    // 权限菜单必须创建到子菜单里
    if (dto.type === MenuType.PERMISSION && !dto.parentId) {
      throw new BizException(ErrorEnum.MENU_PERMISSION_REQUIRE_PARENT);
    }

    let parent;

    if (dto.parentId) {
      parent = await this.getMenuItemInfo(dto.parentId);
      // 父级菜单不存在无法挂载
      if (isEmpty(parent)) {
        throw new BizException(ErrorEnum.MENU_REQUIRE_PARENT);
      }

      if (dto.type === MenuType.MENU) {
        // 菜单不能创建到菜单下
        if (parent && parent.type === MenuType.MENU) {
          throw new BizException(ErrorEnum.MENU_REQUIRE_DIR_PARENT);
        }
      }

      // 权限下不能挂载任何类型的菜单
      if (parent && parent.type === MenuType.PERMISSION) {
        throw new BizException(ErrorEnum.MENU_PERMISSION_NOT_VALID_PARENT);
      }
    }
  }

  /**
   * 更新菜单
   * @param id
   * @param MenuUpdateDto
   */
  async update(id: number, MenuUpdateDto: MenuUpdateDto): Promise<void> {
    await this.menuRepository.update(id, MenuUpdateDto);
  }

  /**
   * 获取当前用户的菜单
   * @param uid 用户id
   */
  async getMenusByUserId(uid: number) {
    const roleIds = await this.roleService.getRoleIdsByUserId(uid);
    let menus: MenuEntity[] = [];
    if (isEmpty(roleIds)) return generateRoutes([]);

    // 超级管理员可以获取所有菜单和权限
    if (await this.roleService.hasSuperAdminRole(roleIds)) {
      menus = await this.menuRepository.find({
        order: {
          order: 'ASC',
        },
      });
    } else {
      menus = await this.menuRepository
        .createQueryBuilder('menu')
        .innerJoinAndSelect('menu.roles', 'role')
        .andWhere('role.id IN (:...roleIds)', { roleIds })
        .orderBy('menu.order', 'ASC')
        .getMany();
    }

    const menuList = generateRoutes(menus);

    return menuList;
  }

  /**
   * 获取所有的菜单
   */
  async getAllMenus() {
    const menus = await this.menuRepository
      .createQueryBuilder('menu')
      .orderBy('menu.order', 'ASC')
      .getMany();

    const menuList = generateRoutes(menus);

    return menuList;
  }

  /**
   * 验证菜单是否被角色使用
   * @param menuId
   */
  async validateRoleUsed(menuId: number) {
    return !!(await this.roleRepository.findOne({
      where: {
        menus: {
          id: menuId,
        },
      },
    }));
  }

  /**
   * 获取当前菜单的所有子级
   * @param parentId
   */
  async findChildMenus(parentId: number): Promise<number[]> {
    const allMenusId: number[] = [];
    // 先找到当前菜单的所有子级
    const menus = await this.menuRepository.findBy({
      parentId,
    });
    // 遍历递归查找子级的子级
    for (const menu of menus) {
      allMenusId.push(menu.id);
      if (menu.type !== MenuType.PERMISSION) {
        const childIds = await this.findChildMenus(menu.id);
        // 这里直接展开
        allMenusId.push(...childIds);
      }
    }

    return allMenusId;
  }

  /**
   * 获取当前用户的所有权限
   * @param uid 用户id
   */
  async getPermissions(uid: number): Promise<string[]> {
    const roleIds = await this.roleService.getRoleIdsByUserId(uid);

    let permissions: string[] = [];
    let result: any = null;
    if (isEmpty(roleIds)) return [];

    result = await this.menuRepository
      .createQueryBuilder('menu')
      .innerJoinAndSelect('menu.roles', 'role')
      .andWhere('role.id IN (:...roleIds)', { roleIds })
      .andWhere('menu.type IN (:...types)', {
        types: [MenuType.MENU, MenuType.PERMISSION],
      })
      .andWhere('menu.permission IS NOT NULL')
      .getMany();

    if (!isEmpty(result)) {
      result.forEach((e) => {
        if (e.permission)
          permissions = permissions.concat(e.permission.split(','));
      });
      permissions = uniq(permissions);
    }

    return permissions;
  }

  async getAllPermissions(): Promise<string[]> {
    let permissions: string[] = [];

    const result = await this.menuRepository
      .createQueryBuilder('menu')
      .where({
        type: In([MenuType.MENU, MenuType.PERMISSION]),
      })
      .andWhere('menu.permission IS NOT NULL')
      .getMany();

    if (!isEmpty(result)) {
      result.forEach((e) => {
        permissions = permissions.concat(e.permission.split(','));
      });
      permissions = uniq(permissions);
    }
    return permissions;
  }

  async batchUpdateStatus({
    ids,
    status,
    updatedBy,
  }: MenuStatusDto): Promise<void> {
    await this.menuRepository.update({ id: In(ids) }, { status, updatedBy });
  }

  /**
   * 删除菜单
   * @param ids
   */
  async delete(ids: number[]): Promise<void> {
    await this.menuRepository.delete(ids);
  }

  /**
   * 刷新所有在线用户权限
   * @param uid
   */
  async refreshOnlineUserPermissions(notify: boolean = true): Promise<void> {
    const onlineUserKeys: string[] = await this.redis.keys(
      genOnlineUserKey('*'),
    );

    if (onlineUserKeys.length === 0) {
      return;
    }

    const users = await this.redis.mget(onlineUserKeys);
    const userIds = users.map(async (u) => {
      const user = JSON.parse(u) as OnlineUser;
      if (user.uid) {
        const permissions = await this.getPermissions(user.uid);
        await this.redis.set(
          genAuthPermKey(user.uid),
          JSON.stringify(permissions),
        );
      }
      return user.uid;
    });

    const ids = await Promise.all(userIds);

    // 通知用户刷新菜单和权限
    if (notify) await this.sseService.notifyClientToUpdateMenusByUserId(ids);
  }
}
