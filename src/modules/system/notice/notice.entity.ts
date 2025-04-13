import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity } from 'typeorm';
import { CompleteEntity } from '~/common/entity/common.eneity';

@Entity('sys_notice')
export class NoticeEntity extends CompleteEntity {
  @ApiProperty({ description: '公告名称' })
  @Column({
    type: 'varchar',
    nullable: true,
    comment: '公告名称',
    length: 50,
  })
  name: string;

  @ApiProperty({ description: '公告类型' })
  @Column({
    type: 'tinyint',
    nullable: false,
    comment: '公告类型 1 公告 2 通知',
    default: 1,
  })
  type: number;

  @ApiProperty({ description: '公告状态' })
  @Column({
    type: 'tinyint',
    nullable: false,
    comment: '公告状态 1 正常 0 停用',
    default: 1,
  })
  status: number;

  @ApiProperty({ description: '公告内容' })
  @Column({
    type: 'text',
    nullable: false,
    comment: '公告内容',
  })
  content: string;
}
