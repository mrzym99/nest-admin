import { HttpAdapterHost, NestFactory, repl } from '@nestjs/core';
import { AppModule } from './app.module';
import { ConfigService } from '@nestjs/config';

import { Logger } from '@nestjs/common';
import { WINSTON_MODULE_NEST_PROVIDER } from 'nest-winston';
import { AllExceptionFilter } from './filters/all-exception-filter';
import { setupSwagger } from './setup-swagger';
import { useContainer } from 'class-validator';
import { ValidationPipe } from './common/pipes/global-validation.pipes';
import { AllConfigKeyAndPath, appRegToken } from './config';
import * as path from 'node:path';
import { LoggingInterceptor } from './common/interceptors/logging.interceptor';
import { isDev, loadHttpOptions } from './utils';
import { NestFastifyApplication } from '@nestjs/platform-fastify';
import { createFastifyApp } from './common/adapters/fastify.adapter';
import { RedisIoAdapter } from './common/adapters/socket.adapter';

declare const module: any;

async function bootstrap() {
  const httpsOptions = await loadHttpOptions(isDev);

  const fastifyApp = await createFastifyApp(httpsOptions);
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule,
    fastifyApp,
    {
      // httpsOptions, // 是否开启 https
      bufferLogs: true, // 缓冲日志
    },
  );

  const configService = app.get(ConfigService<AllConfigKeyAndPath>);
  const { port, globalPrefix } = configService.get(appRegToken, {
    infer: true,
  });

  // class-validator 的 DTO 类中注入 nest 容器的依赖 (用于自定义验证器)
  useContainer(app.select(AppModule), { fallbackOnErrors: true });

  app.enableCors({ origin: '*', credentials: true });
  app.setGlobalPrefix(globalPrefix);
  app.useStaticAssets({
    root: path.join(__dirname, '..', 'public'),
  });

  !isDev && app.enableShutdownHooks();

  if (!isDev) {
    // 启用 nest-winston 日志记录
    app.useLogger(app.get(WINSTON_MODULE_NEST_PROVIDER));
    // 开启可以方便调试 https://docs.nestjs.com/recipes/repl#usage
  }
  // await repl(AppModule);

  app.useGlobalInterceptors(new LoggingInterceptor());

  app.useGlobalPipes(new ValidationPipe());

  const httpAdapter = app.get(HttpAdapterHost);
  app.useGlobalFilters(
    new AllExceptionFilter(
      app.get(WINSTON_MODULE_NEST_PROVIDER),
      httpAdapter,
      configService,
    ),
  );
  app.useWebSocketAdapter(new RedisIoAdapter(app))

  setupSwagger(app, configService);

  await app.listen(port, '0.0.0.0', async () => {
    const logger = new Logger('NestApplication');
    logger.log(`Application is running on: ${await app.getUrl()}`);
    // swagger log
    const swaggerLogger = new Logger('SwaggerModule');
    swaggerLogger.log(`Swagger running on ${await app.getUrl()}/docs`);
  });

  if (module.hot) {
    module.hot.accept();
    module.hot.dispose(() => app.close());
  }
}

bootstrap();
