import { Body, Controller, Get, Post, Query } from '@nestjs/common';
import { StorageService } from './storage.service';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';
import { StorageInfo } from './storage.modal';
import { ApiResult } from '~/common/decorators/api-result.decorator';
import { Pagination } from '~/helper/pagination/pagination';
import { StorageDeleteDto, StoragePageDto } from './storage.dto';

export const permissions = definePermission('tool:storage', {
  LIST: 'list',
  DELETE: 'delete',
} as const);

@ApiTags('Tools - 存储模块')
@ApiSecurityAuth()
@Controller('storage')
export class StorageController {
  constructor(private readonly storageService: StorageService) {}

  @Get('list')
  @ApiOperation({ summary: '获取本地存储列表' })
  @ApiResult({ type: [StorageInfo], isPage: true })
  @Perm(permissions.LIST)
  async list(@Query() dto: StoragePageDto): Promise<Pagination<StorageInfo>> {
    return this.storageService.list(dto);
  }

  @ApiOperation({ summary: '删除文件' })
  @Post('delete')
  @Perm(permissions.DELETE)
  async delete(@Body() dto: StorageDeleteDto): Promise<void> {
    await this.storageService.delete(dto.ids);
  }
}
