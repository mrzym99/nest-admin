import { Controller, Get, Inject, Query } from '@nestjs/common';
import { AliOssService } from './alioss.service';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';
import { Pagination } from '~/helper/pagination/pagination';
import { OssInfo } from './oss.model';
import { OssPageDto } from './oss.dto';
import { QClouldOssService } from './qcloudoss.service';
import { IOssConfig, OssConfig } from '~/config';

export const permissions = definePermission('tool:oss', {
  LIST: 'list',
} as const);

@ApiTags('Tools - oss模块')
@ApiSecurityAuth()
@Controller('oss')
export class OssController {
  constructor(
    @Inject(OssConfig.KEY)
    private readonly ossConfig: IOssConfig,
    private readonly aliOssService: AliOssService,
    private readonly qclouldOssService: QClouldOssService,
  ) {}

  @Get('list')
  @ApiOperation({ summary: '获取Oss存储列表' })
  @Perm(permissions.LIST)
  async list(@Query() dto: OssPageDto): Promise<Pagination<OssInfo>> {
    if (this.ossConfig.type === 'qcloud') {
      return await this.qclouldOssService.list(dto);
    }
    return await this.aliOssService.list(dto);
  }
}
