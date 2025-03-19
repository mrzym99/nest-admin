import { ClassSerializerInterceptor, Module } from '@nestjs/common';
import { APP_GUARD, APP_INTERCEPTOR } from '@nestjs/core';

import { ConfigModule } from '@nestjs/config';
import { SharedModule } from './shared/shared.module';
import { DatabaseModule } from './shared/database/database.module';
import { AppController } from './app.controller';

import { TransformInterceptor } from './common/interceptors/transform.interceptor';
import { AuthModule } from './modules/auth/auth.module';
import { SystemModule } from './modules/system/system.module';
import { JwtAuthGuard } from './modules/auth/guards/jwt-auth.guard';
import { SseModule } from './modules/sse/sse.module';

import config from './config';
import { RbacGuard } from './modules/auth/guards/rbac.guard';
import { ToolModule } from './modules/tools/tool.module';
import { ClsModule } from 'nestjs-cls';
import { TasksModule } from './modules/tasks/tasks.module';
import { TimeoutInterceptor } from './common/interceptors/timeout.interceptor';

@Module({
  imports: [
    // config 模块可以根据 process.env.NODE_ENV 来加载不同的配置文件
    ConfigModule.forRoot({
      isGlobal: true, // 设置为全局模块 可以在任意模块中通过 Inject 使用
      expandVariables: true, // 支持 env 变量嵌套
      envFilePath: [`.env`, `.env.${process.env.NODE_ENV}`],
      load: [...Object.values(config)],
    }),
    // Cls
    ClsModule.forRoot({
      global: true,
      interceptor: {
        mount: true,
        setup: (cls, context) => {
          // cls.set('request', request);
          const req = context.switchToHttp().getRequest();
          if (req.params?.id && req.body) {
            cls.set('operateId', String(req.params.id));
          }
        },
      },
    }),

    SharedModule,
    // 数据库
    DatabaseModule,

    AuthModule,
    SystemModule,
    TasksModule.forRoot(),
    ToolModule,
    SseModule,
  ],
  controllers: [AppController],
  providers: [
    //  interceptors
    {
      provide: APP_INTERCEPTOR, // 全局拦截器 用于处理返回结果
      useClass: TransformInterceptor,
    },
    {
      provide: APP_INTERCEPTOR, // 用于 class-transformer 序列化 返回结果 比如排除某个 @Exclude() 属性
      useClass: ClassSerializerInterceptor,
    },
    {
      provide: APP_INTERCEPTOR, // 全局守卫 用于处理请求
      useFactory: () => new TimeoutInterceptor(),
    },

    // guard
    {
      provide: APP_GUARD,
      useClass: JwtAuthGuard,
    },
    {
      provide: APP_GUARD,
      useClass: RbacGuard,
    },
  ],
  exports: [],
})
export class AppModule {}
