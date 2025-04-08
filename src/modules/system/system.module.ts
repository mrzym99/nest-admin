import { Module } from '@nestjs/common';
import { RouterModule } from '@nestjs/core';

import { DeptModule } from './dept/dept.module';
import { RoleModule } from './role/role.module';
import { UserModule } from '../user/user.module';
import { MenuModule } from './menu/menu.module';
import { LogModule } from './monitor/log/log.module';
import { ParameterModule } from './parameter/parameter.module';
import { ServeModule } from './monitor/serve/serve.module';
import { OnlineModule } from './monitor/online/online.module';
import { TaskModule } from './task/task.module';
import { DictTypeModule } from './dict/type/dict-type.module';
import { DictItemModule } from './dict/item/dict-item.module';
import { CacheModule } from './monitor/cache/cache.module';

const modules = [
  DeptModule,
  RoleModule,
  UserModule,
  MenuModule,
  ParameterModule,
  TaskModule,
  DictTypeModule,
  DictItemModule,
  OnlineModule,
  LogModule,
  ServeModule,
  CacheModule,
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
