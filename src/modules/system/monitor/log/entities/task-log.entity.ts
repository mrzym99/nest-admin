import { Column, Entity, JoinColumn, ManyToOne, Relation } from 'typeorm';
import { CommonEntity } from '~/common/entity/common.eneity';
import { ApiProperty } from '@nestjs/swagger';
import { TaskEntity } from '~/modules/system/task/task.entity';

@Entity({ name: 'sys_task_log' })
export class TaskLogEntity extends CommonEntity {
  @Column({
    type: 'tinyint',
    comment: '任务状态 1 成功 0 失败',
    default: 0,
  })
  @ApiProperty({
    description: '任务状态 1 成功 0 失败',
    default: 0,
  })
  status: number;

  @Column({
    type: 'text',
    nullable: true,
    comment: '任务日志信息',
  })
  @ApiProperty({
    description: '任务日志信息',
  })
  detail: string;

  @Column({
    type: 'int',
    comment: '任务耗时',
    nullable: true,
    default: 0,
    name: 'consume_time',
  })
  @ApiProperty({
    description: '任务耗时',
    default: 0,
  })
  consumeTime: number;

  @ManyToOne(() => TaskEntity)
  @JoinColumn({ name: 'task_id' })
  task: Relation<TaskEntity>;
}
