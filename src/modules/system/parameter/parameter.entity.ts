import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity } from 'typeorm';
import { CompleteEntity } from '~/common/entity/common.eneity';

@Entity('sys_parameter')
export class ParameterEntity extends CompleteEntity {
  @ApiProperty({ description: '参数名称' })
  @Column({
    type: 'varchar',
    nullable: true,
    comment: '参数名称',
    length: 50,
  })
  name: string;

  @ApiProperty({ description: '参数键' })
  @Column({
    type: 'varchar',
    nullable: false,
    comment: '参数键',
  })
  key: string;

  @ApiProperty({ description: '参数值' })
  @Column({
    type: 'varchar',
    nullable: false,
    comment: '参数值',
  })
  value: string;

  @ApiProperty({ description: '备注' })
  @Column({
    type: 'varchar',
    nullable: true,
    comment: '备注',
  })
  remark: string;
}
