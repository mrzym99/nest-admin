import { Controller, Delete, Get, Param } from '@nestjs/common';
import { CacheService } from './cache.service';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { ApiResult } from '~/common/decorators/api-result.decorator';
import { Prefix } from './cache.model';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';

export const permissions = definePermission('system:cache', {
  LIST: 'LIST',
  READ: 'READ',
  DELETE: 'DELETE',
} as const);

@ApiTags('SystemMonitor - 缓存模块')
@ApiSecurityAuth()
@Controller('cache')
export class CacheController {
  constructor(private readonly cacheService: CacheService) {}

  @Get('/getPrefixList')
  @ApiOperation({ summary: '获取缓存前缀列表' })
  @ApiResult({
    type: [Prefix],
  })
  @Perm(permissions.LIST)
  getPrefixList(): Prefix[] {
    return this.cacheService.getPrefixList();
  }

  @Get('keys/:prefix')
  @ApiOperation({ summary: '通过 key 的前缀获取缓存的所有 key' })
  @Perm(permissions.LIST)
  async getKeys(@Param('prefix') prefix: string): Promise<string[]> {
    return await this.cacheService.getKeys(prefix);
  }

  @Get('value/:key')
  @ApiOperation({ summary: '通过 key 获取缓存的值' })
  @Perm(permissions.READ)
  async getValue(@Param('key') key: string): Promise<string> {
    return await this.cacheService.getValue(key);
  }

  @Delete('/:key')
  @ApiOperation({ summary: '通过 key 删除缓存' })
  @Perm(permissions.DELETE)
  async delKey(@Param('key') key: string): Promise<number> {
    return await this.cacheService.delKey(key);
  }

  @Delete('clearCache')
  @ApiOperation({ summary: '清空所有缓存' })
  @Perm(permissions.DELETE)
  async clearCache(): Promise<void> {
    return await this.cacheService.clearCache();
  }

  @Delete('clearPrefixCache/:prefix')
  @ApiOperation({ summary: '通过 prefix 清空所有缓存' })
  @Perm(permissions.DELETE)
  async clearPrefixCache(@Param('prefix') prefix: string): Promise<void> {
    return await this.cacheService.clearPrefixCache(prefix);
  }
}
