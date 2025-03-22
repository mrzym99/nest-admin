import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Delete,
  Query,
  Put,
} from '@nestjs/common';
import { DictItemService } from './dict-item.service';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import {
  DictItemCreateDto,
  DictItemQueryDto,
  DictItemStatusDto,
  DictItemUpdateDto,
} from './dict-item.dto';
import { ApiResult } from '~/common/decorators/api-result.decorator';
import { Pagination } from '~/helper/pagination/pagination';
import { DictItemEntity } from './dict-item.entity';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';
import { DeleteDto } from '~/common/dto/delete.dto';

export const permissions = definePermission('system:dict-item', {
  LIST: 'list',
  CREATE: 'create',
  READ: 'read',
  UPDATE: 'update',
  DELETE: 'delete',
} as const);

@ApiTags('SSystem - 数据字典项模块')
@ApiSecurityAuth()
@Controller('dict-item')
export class DictItemController {
  constructor(private readonly DictItemService: DictItemService) {}

  @Get('list')
  @ApiOperation({ summary: '获取字典项列表' })
  @ApiResult({ type: [DictItemCreateDto], isPage: true })
  @Perm(permissions.LIST)
  async list(
    @Query() dto: DictItemQueryDto,
  ): Promise<Pagination<DictItemEntity>> {
    return await this.DictItemService.list(dto);
  }

  @Post()
  @ApiOperation({ summary: '创建字典项' })
  @Perm(permissions.CREATE)
  async create(@Body() createTypeDto: DictItemCreateDto): Promise<void> {
    await this.DictItemService.create(createTypeDto);
  }

  @Get('info/:id')
  @ApiOperation({ summary: '字典项详情' })
  @ApiResult({ type: DictItemEntity })
  @Perm(permissions.READ)
  info(@Param('id') id: string): Promise<DictItemEntity> {
    return this.DictItemService.info(id);
  }

  @Put('update/:id')
  @ApiOperation({ summary: '修改字典项' })
  @Perm(permissions.UPDATE)
  async update(
    @Param('id') id: string,
    @Body() dto: DictItemUpdateDto,
  ): Promise<void> {
    await this.DictItemService.update(id, dto);
  }

  @Put('updateStatus')
  @ApiOperation({ summary: '修改字典项状态' })
  @Perm(permissions.UPDATE)
  async updateStatus(@Body() dto: DictItemStatusDto): Promise<void> {
    await this.DictItemService.batchUpdateStatus(dto);
  }

  @Delete()
  @ApiOperation({ summary: '删除字典项' })
  @Perm(permissions.DELETE)
  delete(@Body() dto: DeleteDto) {
    const { ids } = dto;
    return this.DictItemService.batchDelete(ids);
  }
}
