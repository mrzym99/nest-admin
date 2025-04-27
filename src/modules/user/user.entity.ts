import {
  Column,
  Entity,
  JoinColumn,
  JoinTable,
  ManyToMany,
  ManyToOne,
  OneToMany,
  OneToOne,
  Relation,
} from 'typeorm';

import { CommonEntity } from '~/common/entity/common.eneity';
import { RoleEntity } from '../system/role/role.entity';
import { ProfileEntity } from './profile.entity';
import { Exclude } from 'class-transformer';
import { DeptEntity } from '../system/dept/dept.entity';
import { ApiProperty } from '@nestjs/swagger';
import { AccessTokenEntity } from '../auth/entities/access-token.entity';

@Entity('user')
export class UserEntity extends CommonEntity {
  @ApiProperty({ description: '用户名' })
  @Column({
    type: 'varchar',
    length: 50,
    unique: true,
    nullable: false,
    comment: '用户名',
  })
  username: string;

  @ApiProperty({ description: '密码' })
  @Column({
    type: 'varchar',
    length: 150,
    nullable: false,
    comment: '密码',
  })
  @Exclude()
  password: string;

  @ApiProperty({ description: '从哪里来的用户' })
  @Column({
    type: 'varchar',
    nullable: true,
    comment: '记录是从哪里来的用户',
  })
  from: string;

  @ApiProperty({ description: '唯一的id 比如 github 的用户id' })
  @Column({
    name: 'unique_id',
    type: 'int',
    comment: '唯一的id',
    nullable: true,
  })
  uniqueId: number;

  @ApiProperty({ description: '状态 1 启用 0 禁用' })
  @Column({
    type: 'tinyint',
    nullable: true,
    default: 1,
    comment: '状态 1 启用 0 禁用',
  })
  status: number;

  @OneToOne(() => ProfileEntity, (profile) => profile.id)
  @JoinColumn({ name: 'profile_id' })
  profile: ProfileEntity;

  @ManyToOne(() => DeptEntity, (dept) => dept.users)
  @JoinColumn({ name: 'dept_id' })
  dept: Relation<DeptEntity>;

  @OneToMany(() => AccessTokenEntity, (accessToken) => accessToken.user, {
    cascade: true,
  })
  accessTokens: Relation<AccessTokenEntity[]>;

  @ManyToMany(() => RoleEntity, (role) => role.users)
  @JoinTable({
    name: 'sys_user_roles',
    joinColumn: {
      name: 'user_id',
      referencedColumnName: 'id',
    },
    inverseJoinColumn: {
      name: 'role_id',
      referencedColumnName: 'id',
    },
  })
  roles: Relation<RoleEntity[]>;
}
