import {
  Controller,
  Get,
  Post,
  Body,
  Put,
  Param,
  Delete,
  Query,
} from '@nestjs/common';
import { DeptService } from './dept.service';
import { DeptCreateDto, DeptQueryDto, DeptUpdateDto } from './dto/dept.dto';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { CreatorPipe } from '~/common/pipes/creator.pipe';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { ApiResult } from '~/common/decorators/api-result.decorator';
import { DeptEntity } from './dept.entity';
import { BusinessException } from '~/common/exceptions/biz.exception';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';
import { ErrorEnum } from '~/constants/error.constant';
import { UpdaterPip } from '~/common/pipes/updater.pipe';
import { ParamId } from '~/common/decorators/param-id.decorator';

export const permissions = definePermission('system:dept', {
  LIST: 'list',
  CREATE: 'create',
  READ: 'read',
  UPDATE: 'update',
  DELETE: 'delete',
} as const);

@ApiSecurityAuth()
@ApiTags('System - 部门模块')
@Controller('dept')
export class DeptController {
  constructor(private readonly deptService: DeptService) {}

  @Get('list')
  @ApiOperation({ summary: '获取部门列表' })
  @ApiResult({ type: [DeptEntity] })
  @Perm(permissions.LIST)
  async list(@Query() dto: DeptQueryDto) {
    return await this.deptService.list(dto);
  }

  @Get('tree')
  @ApiOperation({ summary: '获取部门树' })
  @ApiResult({ type: [DeptEntity] })
  @Perm(permissions.LIST)
  async tree(@Query() dto: DeptQueryDto) {
    return await this.deptService.listDeptTree(dto);
  }

  @Post()
  @ApiOperation({ summary: '创建部门' })
  @Perm(permissions.CREATE)
  async create(@Body(CreatorPipe) dto: DeptCreateDto): Promise<void> {
    await this.deptService.create(dto);
  }

  @Put(':id')
  @ApiOperation({ summary: '更新部门' })
  @Perm(permissions.UPDATE)
  async update(
    @ParamId() id: number,
    @Body(UpdaterPip) DeptUpdateDto: DeptUpdateDto,
  ): Promise<void> {
    await this.deptService.update(id, DeptUpdateDto);
  }

  @Get(':id')
  @ApiOperation({ summary: '查询部门信息' })
  @ApiResult({ type: DeptEntity })
  @Perm(permissions.READ)
  async info(@ParamId() id: number) {
    return await this.deptService.info(id);
  }

  @Put('default/:id')
  @ApiOperation({ summary: '设为默认部门' })
  @Perm(permissions.UPDATE)
  async default(@ParamId() id: number) {
    await this.deptService.default(id);
  }

  @Delete(':id')
  @ApiOperation({ summary: '删除部门' })
  @Perm(permissions.DELETE)
  async delete(@ParamId() id: number): Promise<void> {
    // 判断是否有子部门
    const children = await this.deptService.countChildDept(id);
    if (children > 0) {
      throw new BusinessException(ErrorEnum.DEPT_USED_BY_CHILD);
    }
    // 判断部门是否有用户
    const users = await this.deptService.countDeptUser(id);
    if (users > 0) {
      throw new BusinessException(ErrorEnum.DEPT_USED_BY_USER);
    }
    await this.deptService.delete(id);
  }
}
