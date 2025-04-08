import { ApiProperty } from '@nestjs/swagger';

export class LoginLogInfo {
  @ApiProperty({ description: '日志id' })
  id: string;

  @ApiProperty({ description: 'ip地址', example: '127.0.0.1' })
  ip: string;

  @ApiProperty({ description: '地址' })
  address: string;

  @ApiProperty({ description: '操作系统' })
  os: string;

  @ApiProperty({ description: '浏览器' })
  browser: string;

  @ApiProperty({ description: '用户名' })
  username: string;

  @ApiProperty({ description: '登录时间' })
  time: string;

  @ApiProperty({ description: '昵称' })
  nickName: string;
}

export class TaskLogInfo {
  @ApiProperty({ description: 'id' })
  id: string;

  @ApiProperty({ description: '任务id' })
  taskId: string;

  @ApiProperty({ description: '任务名称' })
  name: string;

  @ApiProperty({ description: '创建时间' })
  createdAt: Date;

  @ApiProperty({ description: '耗时' })
  consumeTime: number;

  @ApiProperty({ description: '详情' })
  detail: string;

  @ApiProperty({ description: '状态' })
  status: number;
}
