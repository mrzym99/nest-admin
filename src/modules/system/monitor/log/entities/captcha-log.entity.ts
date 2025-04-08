import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity } from 'typeorm';
import { CommonEntity } from '~/common/entity/common.eneity';

@Entity({ name: 'sys_captcha_log' })
export class CaptchaLogEntity extends CommonEntity {
  @Column({
    type: 'varchar',
    comment: '账号',
    nullable: true,
  })
  @ApiProperty({ description: '账号' })
  account: string;
  @Column({
    type: 'varchar',
    comment: '验证码',
    nullable: true,
  })
  code: string;

  @Column({
    type: 'varchar',
    comment: '验证码提供商',
    nullable: true,
  })
  @ApiProperty({ description: '验证码提供商' })
  provider: string;
}
