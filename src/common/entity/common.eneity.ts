import { ApiHideProperty, ApiProperty } from '@nestjs/swagger';
import { Exclude } from 'class-transformer';
import {
  BaseEntity,
  Column,
  CreateDateColumn,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { UserEntity } from '~/modules/user/user.entity';

export abstract class CommonEntity extends BaseEntity {
  // 使用 id 作为主键
  // 使用 uuid 作为id
  @ApiProperty({
    description: '主键',
  })
  @PrimaryGeneratedColumn('increment')
  id: number;

  @ApiProperty({
    description: '创建时间',
  })
  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @ApiProperty({
    description: '修改时间',
  })
  @CreateDateColumn({ name: 'updated_at' })
  updatedAt: Date;
}

export abstract class CompleteEntity extends CommonEntity {
  @ApiHideProperty()
  @Exclude()
  @Column({
    name: 'created_by',
    update: false,
    comment: '创建人',
    nullable: true,
  })
  createdBy: number;

  @ApiHideProperty()
  @Exclude()
  @Column({
    name: 'updated_by',
    comment: '修改者',
    nullable: true,
  })
  updatedBy: number;

  // 可以联查将用户信息查出来
  @ManyToOne(() => UserEntity)
  @JoinColumn({ name: 'created_by' })
  creator: UserEntity;

  @ManyToOne(() => UserEntity)
  @JoinColumn({ name: 'updated_by' })
  updater: UserEntity;
}
