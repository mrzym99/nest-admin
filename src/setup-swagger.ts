import { INestApplication } from '@nestjs/common';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { CommonEntity } from './common/entity/common.eneity';
import { ResOp } from './common/model/response.model';
import { Pagination } from './helper/pagination/pagination';
import { knife4jSetup } from 'nestjs-knife4j';
import { ConfigService } from '@nestjs/config';
import { IAppConfig } from './config';
import { API_SECURITY_AUTH } from './common/decorators/swagger.decorators';

export function setupSwagger(
  app: INestApplication,
  configService: ConfigService,
): void {
  const { name } = configService.get<IAppConfig>('app');
  const documentBuilder = new DocumentBuilder()
    .setTitle(name)
    .setDescription(`${name} API Document`)
    .addBearerAuth()
    .setVersion('1.0');

  documentBuilder.addSecurity(API_SECURITY_AUTH, {
    description: '输入令牌（Enter the token）',
    type: 'http',
    scheme: 'bearer',
    bearerFormat: 'JWT',
  });

  const document = SwaggerModule.createDocument(app, documentBuilder.build(), {
    ignoreGlobalPrefix: true,
    deepScanRoutes: true,
    extraModels: [CommonEntity, ResOp, Pagination],
  });

  SwaggerModule.setup('docs', app, document, {
    swaggerOptions: {
      persistAuthorization: true,
    },
  });

  knife4jSetup(app, {
    urls: [
      {
        name: '版本 1.0.0',
        url: `/docs-json`,
        swaggerVersion: '8.1.0',
        location: `/docs-json`,
      },
    ],
  });
}
