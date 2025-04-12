import { Column, Entity, ManyToMany, Relation } from 'typeorm';
import { CompleteEntity } from '~/common/entity/common.eneity';
import { RoleEntity } from '../role/role.entity';

@Entity('sys_menu')
export class MenuEntity extends CompleteEntity {
  @Column({ name: 'parent_id', nullable: true, comment: '菜单父级ID' })
  parentId: number;

  @Column({ nullable: true, comment: '菜单类型' })
  type: number;

  @Column({ nullable: true, comment: '菜单/权限名称' })
  title: string;

  @Column({ nullable: true, comment: '国际化 key', name: 'i18n_key' })
  i18nKey: string;

  @Column({ nullable: true, comment: '路由名称' })
  name: string;

  @Column({ nullable: true, comment: '菜单路径' })
  path: string;

  @Column({ nullable: true, comment: '路由名称', name: 'route_name' })
  routeName: string;

  @Column({ nullable: true, comment: '菜单组件' })
  component: string;

  @Column({ nullable: true, comment: '菜单权限' })
  permission: string;

  @Column({ nullable: true, comment: '菜单图标' })
  icon: string;

  @Column({ nullable: true, comment: '图标类型', name: 'icon_type' })
  iconType: number;

  @Column({ type: 'int', nullable: true, comment: '菜单排序', default: 0 })
  order: number;

  @Column({
    name: 'is_ext',
    type: 'boolean',
    nullable: true,
    comment: '是否外链',
    default: false,
  })
  isExt: boolean;

  @Column({
    name: 'ext_open_mode',
    type: 'tinyint',
    nullable: true,
    comment: '外链打开模式 1 项目内打开 2 项目外打开',
    default: 1,
  })
  extOpenMode: number;

  @Column({
    type: 'varchar',
    nullable: true,
    comment: '外链地址',
  })
  href: string;

  @Column({
    name: 'keep_alive',
    type: 'boolean',
    nullable: true,
    comment: '是否缓存',
    default: false,
  })
  keepAlive: boolean;

  @Column({
    type: 'boolean',
    nullable: true,
    comment: '是否隐藏',
    default: false,
    name: 'hide_in_menu',
  })
  hideInMenu: boolean;

  @Column({
    name: 'active_menu',
    nullable: true,
    comment: '设置当前路由高亮的菜单项，一般用于详情页',
  })
  activeMenu: string;

  @Column({
    type: 'boolean',
    nullable: true,
    comment: '是否显示多标签页',
    default: false,
    name: 'multi_tab',
  })
  multiTab: boolean;

  @Column({
    type: 'int',
    nullable: true,
    comment: '是否显示多标签页',
    default: null,
    name: 'fixed_index_in_tab',
  })
  fixedIndexInTab: number;

  @Column({
    type: 'int',
    nullable: true,
    comment: '菜单状态 1 启用 0 禁用',
    default: 1,
  })
  status: number;

  @ManyToMany(() => RoleEntity, (role) => role.menus, {
    onDelete: 'CASCADE',
  })
  roles: Relation<RoleEntity[]>;
}
