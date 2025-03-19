import { CommonEntity } from '~/common/entity/common.eneity';
import { Column, Entity } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';

@Entity('user_profile')
export class ProfileEntity extends CommonEntity {
  @ApiProperty({ description: '昵称' })
  @Column({
    name: 'nick_name',
    type: 'varchar',
    length: 20,
    nullable: true,
    comment: '昵称',
  })
  nickName: string;

  @ApiProperty({ description: '性别 1 男 0 女' })
  @Column({
    type: 'enum',
    enum: [0, 1],
    default: 1,
    comment: '性别 1 男 0 女',
  })
  gender: number;

  @ApiProperty({ description: '邮箱' })
  @Column({
    type: 'varchar',
    length: 25,
    nullable: true,
    comment: 'email',
  })
  email: string;

  @ApiProperty({ description: '手机号' })
  @Column({
    type: 'varchar',
    length: 11,
    nullable: true,
    comment: '手机号',
  })
  phone: string;

  @ApiProperty({ description: '头像' })
  @Column({
    type: 'varchar',
    length: 255,
    nullable: true,
    comment: '头像',
  })
  avatar: string;

  @ApiProperty({ description: '个人签名' })
  @Column({
    type: 'varchar',
    length: 255,
    nullable: true,
    comment: '个人签名',
  })
  signature: string;

  @ApiProperty({ description: '地址' })
  @Column({
    type: 'varchar',
    length: 255,
    nullable: true,
    comment: '地址',
  })
  address: string;

  @ApiProperty({ description: '出生日期' })
  @Column({
    name: 'birth_date',
    type: 'datetime',
    nullable: true,
    comment: '出生日期',
  })
  birthDate: Date;

  @ApiProperty({ description: '简介' })
  @Column({
    type: 'longtext',
    nullable: true,
    comment: '简介',
  })
  introduction: string;
}
