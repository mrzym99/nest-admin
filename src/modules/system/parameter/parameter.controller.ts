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
import { ParameterService } from './parameter.service';
import {
  ParameterCreateDto,
  ParameterQueryDto,
  ParameterUpdateDto,
} from './dto/parameter.dto';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { ApiResult } from '~/common/decorators/api-result.decorator';
import { ParameterEntity } from './parameter.entity';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';
import { Public } from '~/modules/auth/decorators/public.decorator';
import { CreatorPipe } from '~/common/pipes/creator.pipe';
import { UpdaterPip } from '~/common/pipes/updater.pipe';
import { ParamId } from '~/common/decorators/param-id.decorator';

export const permissions = definePermission('system:parameter', {
  LIST: 'list',
  CREATE: 'create',
  READ: 'read',
  UPDATE: 'update',
  DELETE: 'delete',
} as const);

@ApiSecurityAuth()
@ApiTags('System - 参数模块')
@Controller('parameter')
export class ParameterController {
  constructor(private readonly parameterService: ParameterService) {}

  @Get('list')
  @ApiOperation({ summary: '查询参数列表' })
  @ApiResult({ type: [ParameterEntity], isPage: true })
  @Perm(permissions.LIST)
  list(@Query() dto: ParameterQueryDto) {
    return this.parameterService.list(dto);
  }

  @Post()
  @ApiOperation({ summary: '创建参数' })
  @Perm(permissions.CREATE)
  async create(@Body(CreatorPipe) createParameterDto: ParameterCreateDto) {
    await this.parameterService.create(createParameterDto);
  }

  @Get('info/:id')
  @ApiOperation({ summary: '查询参数详情' })
  @Perm(permissions.READ)
  async findOne(@ParamId() id: number) {
    return await this.parameterService.findOne(id);
  }

  @Get('value/:key')
  @ApiOperation({ summary: '提供 key 查询 参数 value' })
  @Public()
  async findValueByKey(@Param('key') key: string) {
    return await this.parameterService.findOneByKey(key);
  }

  @Put(':id')
  @ApiOperation({ summary: '更新参数' })
  @Perm(permissions.UPDATE)
  async update(
    @ParamId() id: number,
    @Body(UpdaterPip) dto: ParameterUpdateDto,
  ) {
    await this.parameterService.update(id, dto);
  }

  @Delete(':id')
  @ApiOperation({ summary: '删除参数' })
  @Perm(permissions.DELETE)
  async delete(@ParamId() id: number) {
    await this.parameterService.delete(id);
  }
}
