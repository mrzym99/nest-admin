import { ApiHideProperty, ApiProperty } from '@nestjs/swagger';
import { Column, Entity, JoinTable, ManyToMany, Relation } from 'typeorm';
import { CompleteEntity } from '~/common/entity/common.eneity';
import { UserEntity } from '~/modules/user/user.entity';
import { MenuEntity } from '../menu/menu.entity';

@Entity('sys_role')
export class RoleEntity extends CompleteEntity {
  @ApiProperty({ description: '角色名称' })
  @Column({ type: 'varchar', length: 50, unique: true, comment: '角色名称' })
  name: string;

  @ApiProperty({ description: '角色标识' })
  @Column({ type: 'varchar', length: 50, unique: true, comment: '角色标识' })
  value: string;

  @ApiProperty({ description: '角色描述' })
  @Column({ type: 'varchar', length: 255, nullable: true, comment: '角色描述' })
  description: string;

  @ApiProperty({ description: '角色状态 1 启用 0 禁用' })
  @Column({ type: 'tinyint', default: 1, comment: '角色状态 1 启用 0 禁用' })
  status: number;

  @ApiProperty({ description: '是否系统默认角色 1 是 0 否' })
  @Column({ type: 'tinyint', nullable: true, comment: '是否系统默认角色' })
  default: number;

  @ApiHideProperty()
  @ManyToMany(() => UserEntity, (user) => user.roles)
  users: Relation<UserEntity[]>;

  @ApiHideProperty()
  @ManyToMany(() => MenuEntity, (menu) => menu.roles)
  @JoinTable({
    name: 'sys_role_menus',
    joinColumn: {
      name: 'role_id',
      referencedColumnName: 'id',
    },
    inverseJoinColumn: {
      name: 'menu_id',
      referencedColumnName: 'id',
    },
  })
  menus: Relation<MenuEntity[]>;
}
