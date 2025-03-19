import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Delete,
  Put,
  Query,
  Inject,
  forwardRef,
} from '@nestjs/common';
import { RoleService } from './role.service';
import { RoleCreateDto, RoleUpdateDto, RoleQueryDto } from './dto/role.dto';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiResult } from '~/common/decorators/api-result.decorator';
import { RoleEntity } from './role.entity';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { CreatorPipe } from '~/common/pipes/creator.pipe';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';
import { SseService } from '~/modules/sse/sse.service';
import { MenuService } from '../menu/menu.service';

export const permissions = definePermission('system:role', {
  LIST: 'list',
  CREATE: 'create',
  READ: 'read',
  UPDATE: 'update',
  DELETE: 'delete',
} as const);

@ApiTags('System - 角色模块')
@ApiSecurityAuth()
@Controller('role')
export class RoleController {
  constructor(
    private readonly roleService: RoleService,
    @Inject(forwardRef(() => SseService))
    private readonly sseService: SseService,
    private readonly menuService: MenuService,
  ) {}

  @Get('list')
  @ApiOperation({ summary: '获取角色列表' })
  @ApiResult({ type: [RoleEntity], isPage: true })
  @Perm(permissions.LIST)
  list(@Query() dto: RoleQueryDto) {
    return this.roleService.list(dto);
  }

  @Get('all')
  @ApiOperation({ summary: '获取所有可用角色' })
  @Perm(permissions.LIST)
  getAll() {
    return this.roleService.getAllEnableRoles();
  }

  @Post()
  @ApiOperation({ summary: '创建角色' })
  @Perm(permissions.CREATE)
  async create(@Body(CreatorPipe) RoleCreateDto: RoleCreateDto): Promise<void> {
    await this.roleService.create(RoleCreateDto);
  }

  @Put(':id')
  @ApiOperation({ summary: '更新角色' })
  @Perm(permissions.UPDATE)
  async update(
    @Param('id') id: string,
    @Body() RoleUpdateDto: RoleUpdateDto,
  ): Promise<void> {
    await this.roleService.update(id, RoleUpdateDto);
    //  更新角色对应的用户权限 只进行更新 redis 缓存
    await this.menuService.refreshOnlineUserPermissions(false);
    // 通知该角色下的用户进行菜单更新
    await this.sseService.noticeClientToUpdateMenusByRoleIds([id]);
  }

  @Get('info/:id')
  @ApiOperation({ summary: '获取角色信息' })
  @ApiResult({ type: RoleEntity })
  @Perm(permissions.READ)
  async info(@Param('id') id: string) {
    return await this.roleService.info(id);
  }

  @Put('default/:id')
  @ApiOperation({ summary: '设为默认角色' })
  @Perm(permissions.UPDATE)
  async default(@Param('id') id: string) {
    return await this.roleService.default(id);
  }

  @Delete(':id')
  @ApiOperation({ summary: '删除角色' })
  @Perm(permissions.DELETE)
  async delete(@Param('id') id: string): Promise<void> {
    // 判断此角色是否关联了用户 关联了用户就不能通过校验 不能删除
    await this.roleService.validateRelateUser(id);
    // 默认角色不能删除
    await this.roleService.validateIsDefault(id);
    await this.roleService.delete(id);
  }
}
