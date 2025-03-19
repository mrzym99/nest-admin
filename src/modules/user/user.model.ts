import { ApiProperty } from '@nestjs/swagger';
import { DeptEntity } from '../system/dept/dept.entity';
import { RoleEntity } from '../system/role/role.entity';

export class UserProfile {
  @ApiProperty({
    type: String,
    description: '昵称',
    example: 'Mick',
    required: false,
  })
  nickName?: string;

  @ApiProperty({
    type: String,
    description: '性别 1 男 0 女',
    required: false,
  })
  gender?: number;

  @ApiProperty({
    type: String,
    description: '手机号',
    required: false,
  })
  phone?: string;

  @ApiProperty({
    type: String,
    description: '头像',
    required: false,
  })
  avatar?: string;

  @ApiProperty({
    type: String,
    description: '个人签名',
    required: false,
  })
  signature?: string;

  @ApiProperty({
    type: String,
    description: '地址',
    required: false,
  })
  address?: string;

  @ApiProperty({
    type: Date,
    nullable: true,
    description: '出生日期',
    required: false,
  })
  birthDate?: Date;

  @ApiProperty({
    type: String,
    description: '简介',
    required: false,
  })
  introduction?: string;
}

export class UserInfo extends UserProfile {
  @ApiProperty({
    type: String,
    description: '账户',
  })
  username?: string;

  @ApiProperty({
    type: Number,
    description: '状态 1 启用 0 禁用',
  })
  status?: number;

  @ApiProperty({
    type: DeptEntity,
    description: '部门',
  })
  dept: DeptEntity;

  @ApiProperty({
    type: [RoleEntity],
    description: '角色',
  })
  roles: RoleEntity[];
}
