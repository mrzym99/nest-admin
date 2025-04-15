import { Controller, Get, Post, Req, Res } from '@nestjs/common';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { Response } from 'express';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';
import { SqlService } from './sql.service';
import { BusinessException } from '~/common/exceptions/biz.exception';
import { ErrorEnum } from '~/constants/error.constant';
import { FastifyRequest } from 'fastify';

export const permissions = definePermission('tool:sql', {
  EXPORT: 'export',
  IMPORT: 'import',
} as const);

@ApiTags('Tools - sql导入导出模块')
@ApiSecurityAuth()
@Controller('sql')
export class SqlController {
  constructor(private readonly sqlService: SqlService) {}

  @Get('export')
  @ApiOperation({ summary: '导出数据库结构和数据' })
  @Perm(permissions.EXPORT)
  async export(@Res() res: Response) {
    try {
      const filePath = await this.sqlService.export();
      return res.download(filePath, (err) => {
        if (err) {
          console.error('下载失败', err);
          throw new BusinessException(ErrorEnum.SQL_EXPORT_FAIL);
        }
      });
    } catch (error) {
      console.error('导出失败', error);
      throw new BusinessException(ErrorEnum.SQL_EXPORT_FAIL);
    }
  }

  @Post('import')
  @ApiOperation({ summary: '导入数据库结构和数据' })
  @Perm(permissions.IMPORT)
  async import(@Req() req: FastifyRequest): Promise<void> {
    if (!req.file()) {
      throw new BusinessException(ErrorEnum.SQL_NOT_FOUND);
    }

    try {
      const file = await req.file();
      const fileStream = await file.toBuffer();
      await this.sqlService.import(fileStream);
    } catch (error) {
      throw new BusinessException(ErrorEnum.SQL_IMPORT_FAIL);
    }
  }
}
