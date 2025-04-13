import {
  Controller,
  Get,
  Post,
  Body,
  Delete,
  Query,
  Put,
} from '@nestjs/common';
import { NoticeService } from './notice.service';
import {
  NoticeCreateDto,
  NoticeQueryDto,
  NoticeUpdateDto,
} from './dto/notice.dto';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { ApiResult } from '~/common/decorators/api-result.decorator';
import { NoticeEntity } from './notice.entity';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';
import { CreatorPipe } from '~/common/pipes/creator.pipe';
import { UpdaterPip } from '~/common/pipes/updater.pipe';
import { ParamId } from '~/common/decorators/param-id.decorator';
import { DictTypeStatusDto } from '../dict/type/dict-type.dto';

export const permissions = definePermission('system:notice', {
  LIST: 'list',
  CREATE: 'create',
  READ: 'read',
  UPDATE: 'update',
  DELETE: 'delete',
} as const);

@ApiSecurityAuth()
@ApiTags('System - 公告模块')
@Controller('notice')
export class NoticeController {
  constructor(private readonly noticeService: NoticeService) {}

  @Get('list')
  @ApiOperation({ summary: '查询公告列表' })
  @ApiResult({ type: [NoticeEntity], isPage: true })
  @Perm(permissions.LIST)
  list(@Query() dto: NoticeQueryDto) {
    return this.noticeService.list(dto);
  }

  @Post()
  @ApiOperation({ summary: '创建公告' })
  @Perm(permissions.CREATE)
  async create(@Body(CreatorPipe) createNoticeDto: NoticeCreateDto) {
    await this.noticeService.create(createNoticeDto);
  }

  @Get('info/:id')
  @ApiOperation({ summary: '查询公告详情' })
  @Perm(permissions.READ)
  async findOne(@ParamId() id: number) {
    return await this.noticeService.findOne(id);
  }

  @Put(':id')
  @ApiOperation({ summary: '更新公告' })
  @Perm(permissions.UPDATE)
  async update(@ParamId() id: number, @Body(UpdaterPip) dto: NoticeUpdateDto) {
    await this.noticeService.update(id, dto);
  }

  @Put('updateStatus')
  @ApiOperation({ summary: '修改公告状态' })
  @Perm(permissions.UPDATE)
  async updateStatus(@Body(UpdaterPip) dto: DictTypeStatusDto) {
    await this.noticeService.batchUpdateStatus(dto);
  }

  @Delete(':id')
  @ApiOperation({ summary: '删除公告' })
  @Perm(permissions.DELETE)
  async delete(@ParamId() id: number) {
    await this.noticeService.delete(id);
  }
}
