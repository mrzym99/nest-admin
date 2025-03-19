import { ApiHideProperty, ApiProperty } from '@nestjs/swagger';
import { Exclude } from 'class-transformer';
import {
  BaseEntity,
  Column,
  CreateDateColumn,
  PrimaryGeneratedColumn,
} from 'typeorm';

export abstract class CommonEntity extends BaseEntity {
  // 使用 id 作为主键
  // 使用 uuid 作为id
  @ApiProperty({
    description: '主键',
  })
  @PrimaryGeneratedColumn('uuid')
  id: string;

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
  createdBy: string;

  @ApiHideProperty()
  @Exclude()
  @Column({
    name: 'updated_by',
    comment: '修改者',
    nullable: true,
  })
  updatedBy: string;
}
