import { ApiProperty, OmitType } from '@nestjs/swagger';
import { LoginLogInfo } from '../log/models/log.model';

export class OnlineUser extends OmitType(LoginLogInfo, ['id'] as const) {
  @ApiProperty({ description: 'tokenId' })
  tokenId: number;

  @ApiProperty({ description: '部门名称' })
  deptName: string;

  @ApiProperty({ description: '用户id' })
  uid: number;

  @ApiProperty({ description: '是否当前登录用户' })
  isCurrentUser?: boolean;

  @ApiProperty({ description: '不允许踢当前用户或超级管理员下线' })
  disabled?: boolean;
}
