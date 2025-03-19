import { Body, Controller, Get, Post, Query } from '@nestjs/common';
import { AliOssService } from './alioss.service';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';
import { ApiResult } from '~/common/decorators/api-result.decorator';
import { Pagination } from '~/helper/pagination/pagination';
import { OssInfo } from './oss.model';
import { OssPageDto } from './oss.dto';

export const permissions = definePermission('tool:oss', {
  LIST: 'list',
} as const);

@ApiTags('Tools - oss模块')
@ApiSecurityAuth()
@Controller('oss')
export class OssController {
  constructor(private readonly aliOssService: AliOssService) {}

  @Get('list')
  @ApiOperation({ summary: '获取Oss存储列表' })
  @Perm(permissions.LIST)
  async list(@Query() dto: OssPageDto): Promise<Pagination<OssInfo>> {
    return this.aliOssService.list(dto);
  }
}
