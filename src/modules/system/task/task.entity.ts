import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity } from 'typeorm';
import { CommonEntity } from '~/common/entity/common.eneity';

@Entity('sys_task')
export class TaskEntity extends CommonEntity {
  @Column({
    type: 'varchar',
    length: 50,
    comment: '任务名称',
  })
  @ApiProperty({
    description: '任务名称',
  })
  name: string;

  @Column({
    type: 'varchar',
    comment: '任务服务',
  })
  @ApiProperty({
    description: '任务服务',
  })
  service: string;

  @Column({
    type: 'tinyint',
    comment: '任务类型 1:cron 2:interval',
    default: 1,
  })
  @ApiProperty({
    description: '任务类型 1:cron 2:interval',
    default: 1,
  })
  type: number;

  @Column({
    type: 'tinyint',
    comment: '任务状态 1 启用 0 禁用',
    default: 1,
  })
  @ApiProperty({
    description: '任务状态 1 启用 0 禁用',
    default: 1,
  })
  status: number;

  @Column({
    name: 'start_time',
    type: 'datetime',
    comment: '开始时间',
    nullable: true,
  })
  @ApiProperty({
    description: '开始时间',
    default: null,
  })
  startTime: Date;

  @Column({
    name: 'end_time',
    type: 'datetime',
    comment: '结束时间',
    nullable: true,
  })
  @ApiProperty({
    description: '结束时间',
    default: null,
  })
  endTime: Date;

  @Column({
    type: 'int',
    comment: '限制执行次数，负数则无限制',
    nullable: true,
    default: 0,
  })
  @ApiProperty({
    description: '限制执行次数，负数则无限制',
    default: 0,
  })
  limit: number;

  @Column({
    type: 'varchar',
    comment: 'Cron表达式',
    nullable: true,
  })
  @ApiProperty({
    description: 'Cron表达式',
    default: null,
  })
  cron: string;

  @Column({
    type: 'int',
    comment: '执行间隔，毫秒单位',
    nullable: true,
  })
  @ApiProperty({
    description: '执行间隔，毫秒单位',
    default: null,
  })
  every: number;

  @Column({
    type: 'text',
    comment: '执行数据',
    nullable: true,
  })
  @ApiProperty({
    description: '执行选项配置',
    default: null,
  })
  data: string;

  @Column({
    type: 'text',
    comment: '执行选项配置',
    nullable: true,
  })
  @ApiProperty({
    description: '执行选项配置',
    default: null,
  })
  jobOpts: string;

  @Column({
    type: 'varchar',
    comment: '备注',
    nullable: true,
  })
  @ApiProperty({
    description: '备注',
    default: null,
  })
  remark: string;
}
