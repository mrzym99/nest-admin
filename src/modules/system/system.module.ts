import { Module } from '@nestjs/common';
import { RouterModule } from '@nestjs/core';

import { DeptModule } from './dept/dept.module';
import { RoleModule } from './role/role.module';
import { UserModule } from '../user/user.module';
import { MenuModule } from './menu/menu.module';
import { LogModule } from './log/log.module';
import { ParameterModule } from './parameter/parameter.module';
import { ServeModule } from './serve/serve.module';
import { OnlineModule } from './online/online.module';
import { TaskModule } from './task/task.module';

const modules = [
  DeptModule,
  RoleModule,
  UserModule,
  MenuModule,
  LogModule,
  ParameterModule,
  ServeModule,
  OnlineModule,
  TaskModule,
];

@Module({
  imports: [
    ...modules,
    RouterModule.register([
      {
        path: 'system',
        module: SystemModule,
        children: [...modules],
      },
    ]),
  ],
  exports: [...modules],
})
export class SystemModule {}
