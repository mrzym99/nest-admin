import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity, JoinColumn, ManyToOne, Relation } from 'typeorm';
import { CommonEntity } from '~/common/entity/common.eneity';
import { UserEntity } from '~/modules/user/user.entity';

@Entity('sys_login_log')
export class LoginLogEntity extends CommonEntity {
  @Column({ nullable: true })
  @ApiProperty({ description: 'IP 地址' })
  ip: string;

  @Column({ nullable: true })
  @ApiProperty({ description: '登录地点' })
  address: string;

  @Column({ nullable: true })
  @ApiProperty({ description: '登录方式' })
  provider: string;

  @Column({ name: 'user_agent', nullable: true })
  @ApiProperty({ description: '浏览器 ua' })
  userAgent: string;

  @ManyToOne(() => UserEntity, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user: Relation<UserEntity>;
}
