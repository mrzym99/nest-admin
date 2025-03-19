import { Controller, Get, UseInterceptors } from '@nestjs/common';
import { ServeService } from './serve.service';
import { ApiExtraModels, ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { CacheInterceptor, CacheKey, CacheTTL } from '@nestjs/cache-manager';
import { ServeStatInfo } from './serve.model';
import { ApiResult } from '~/common/decorators/api-result.decorator';

@ApiSecurityAuth()
@ApiTags('System - 服务监控')
@Controller('serve')
@ApiExtraModels(ServeStatInfo)
@UseInterceptors(CacheInterceptor)
@CacheKey('serve_stat')
@CacheTTL(60 * 60 * 24)
export class ServeController {
  constructor(private readonly serveService: ServeService) {}

  @Get()
  @ApiOperation({ summary: '获取服务状态' })
  @ApiResult({ type: ServeStatInfo })
  async stat(): Promise<ServeStatInfo> {
    return await this.serveService.stat();
  }
}
