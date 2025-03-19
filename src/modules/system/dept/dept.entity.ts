import { ApiHideProperty, ApiProperty } from '@nestjs/swagger';
import {
  Column,
  Entity,
  OneToMany,
  Relation,
  Tree,
  TreeChildren,
  TreeParent,
} from 'typeorm';
import { CompleteEntity } from '~/common/entity/common.eneity';
import { UserEntity } from '~/modules/user/user.entity';

@Entity('sys_dept')
@Tree('materialized-path')
export class DeptEntity extends CompleteEntity {
  @ApiProperty({ description: '部门名称' })
  @Column({
    type: 'varchar',
    length: 50,
    comment: '部门名称',
  })
  name: string;

  @ApiProperty({ description: '排序' })
  @Column({
    type: 'int',
    comment: '排序',
    nullable: true,
    default: 0,
  })
  order: number;

  @ApiProperty({ description: '是否系统默认 1 是 0 否' })
  @Column({
    type: 'tinyint',
    comment: '是否系统默认部门',
    default: 0,
  })
  default: number;

  @TreeChildren({ cascade: true })
  children: DeptEntity[];

  @TreeParent({ onDelete: 'SET NULL' })
  parent?: DeptEntity;

  @ApiHideProperty()
  @OneToMany(() => UserEntity, (user) => user.dept)
  users: Relation<UserEntity[]>;
}
