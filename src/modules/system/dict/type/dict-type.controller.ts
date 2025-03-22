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
import { DictTypeService } from './dict-type.service';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import {
  DictTypeCreateDto,
  DictTypeQueryDto,
  DictTypeStatusDto,
  DictTypeUpdateDto,
} from './dict-type.dto';
import { ApiResult } from '~/common/decorators/api-result.decorator';
import { Pagination } from '~/helper/pagination/pagination';
import { DictTypeEntity } from './dict-type.entity';
import { DictItemEntity } from '../item/dict-item.entity';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';

export const permissions = definePermission('system:dict-type', {
  LIST: 'list',
  CREATE: 'create',
  READ: 'read',
  UPDATE: 'update',
  DELETE: 'delete',
} as const);

@ApiTags('SSystem - 数据字典类型模块')
@ApiSecurityAuth()
@Controller('dict-type')
export class DictTypeController {
  constructor(private readonly dictTypeService: DictTypeService) {}

  @Get('list')
  @ApiOperation({ summary: '获取字典类型列表' })
  @ApiResult({ type: [DictTypeCreateDto], isPage: true })
  @Perm(permissions.LIST)
  async list(
    @Query() dto: DictTypeQueryDto,
  ): Promise<Pagination<DictTypeEntity>> {
    return await this.dictTypeService.list(dto);
  }

  @Get('dictItemList/:code')
  @ApiOperation({ summary: '根据字典类型code获取字典项列表' })
  @ApiResult({ type: [DictItemEntity] })
  async dictItemList(@Param('code') code: string): Promise<DictItemEntity[]> {
    return await this.dictTypeService.dictItemList(code);
  }

  @Post()
  @ApiOperation({ summary: '创建字典类型' })
  @Perm(permissions.CREATE)
  async create(@Body() createTypeDto: DictTypeCreateDto): Promise<void> {
    await this.dictTypeService.create(createTypeDto);
  }

  @Get('info/:id')
  @ApiOperation({ summary: '字典类型详情' })
  @ApiResult({ type: DictTypeEntity })
  @Perm(permissions.READ)
  info(@Param('id') id: string): Promise<DictTypeEntity> {
    return this.dictTypeService.info(id);
  }

  @Put('update/:id')
  @ApiOperation({ summary: '修改字典类型' })
  @Perm(permissions.UPDATE)
  async update(
    @Param('id') id: string,
    @Body() dto: DictTypeUpdateDto,
  ): Promise<void> {
    await this.dictTypeService.update(id, dto);
  }

  @Put('updateStatus')
  @ApiOperation({ summary: '修改字典类型状态' })
  @Perm(permissions.UPDATE)
  async updateStatus(@Body() dto: DictTypeStatusDto): Promise<void> {
    await this.dictTypeService.batchUpdateStatus(dto);
  }

  @Delete(':id')
  @ApiOperation({ summary: '删除字典类型' })
  @Perm(permissions.DELETE)
  delete(@Param('id') id: string) {
    return this.dictTypeService.delete(id);
  }
}
