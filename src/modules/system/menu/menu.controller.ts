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
import { MenuService } from './menu.service';
import {
  MenuCreateDto,
  MenuQueryDto,
  MenuStatusDto,
  MenuUpdateDto,
} from './dto/create-menu.dto';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { ApiResult } from '~/common/decorators/api-result.decorator';
import { MenuInfoModel, MenuModel } from './menu.model';
import { BizException } from '~/common/exceptions/biz.exception';
import { ErrorEnum } from '~/constants/error.constant';
import {
  definePermission,
  getDefinePermissions,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';

export const permissions = definePermission('system:menu', {
  LIST: 'list',
  CREATE: 'create',
  READ: 'read',
  UPDATE: 'update',
  DELETE: 'delete',
} as const);

@ApiSecurityAuth()
@ApiTags('System - 菜单模块')
@Controller('menu')
export class MenuController {
  constructor(private readonly menuService: MenuService) {}

  @Get('list')
  @ApiOperation({ summary: '获取所有菜单列表' })
  @ApiResult({ type: [MenuModel] })
  @Perm(permissions.LIST)
  async list(@Query() dto: MenuQueryDto) {
    return await this.menuService.list(dto);
  }

  @Get('tree')
  @ApiOperation({ summary: '获取菜单树' })
  @ApiResult({ type: [MenuModel] })
  @Perm(permissions.LIST)
  async tree() {
    return await this.menuService.listMenuTree();
  }

  @Post()
  @ApiOperation({ summary: '创建菜单或权限' })
  @Perm(permissions.CREATE)
  async create(@Body() MenuCreateDto: MenuCreateDto): Promise<void> {
    // 验证菜单或权限 有没有重复添加
    await this.menuService.validateRepeat(MenuCreateDto);
    await this.menuService.validate(MenuCreateDto);
    await this.menuService.create(MenuCreateDto);
  }

  @Put('update/:id')
  @ApiOperation({ summary: '更新菜单或权限' })
  @Perm(permissions.UPDATE)
  async update(
    @Param('id') id: string,
    @Body() menuUpdateDto: MenuUpdateDto,
  ): Promise<void> {
    await this.menuService.validateRepeat(menuUpdateDto, id);
    await this.menuService.validate(menuUpdateDto);
    await this.menuService.update(id, menuUpdateDto);
  }

  @Get('info/:id')
  @ApiOperation({ summary: '获取菜单详情' })
  @ApiResult({ type: [MenuInfoModel] })
  @Perm(permissions.READ)
  findOne(@Param('id') id: string) {
    return this.menuService.getMenuItemAndParentInfo(id);
  }

  @Get('permissions')
  @ApiOperation({ summary: '获取后端定义的所有权限' })
  async permissions(): Promise<string[]> {
    return await getDefinePermissions();
  }

  @Put('updateStatus')
  @ApiOperation({ summary: '修改菜单状态' })
  @Perm(permissions.UPDATE)
  async updateStatus(@Query() dto: MenuStatusDto): Promise<void> {
    await this.menuService.batchUpdateStatus(dto);
  }

  @Delete(':id')
  @ApiOperation({ summary: '删除菜单或权限' })
  @Perm(permissions.DELETE)
  async delete(@Param('id') id: string): Promise<void> {
    //判断这个菜单是否有角色引用
    if (await this.menuService.validateRoleUsed(id)) {
      throw new BizException(ErrorEnum.MENU_USED_BY_ROLE);
    }
    // 获取这个菜单的所有子菜单
    const ids: string[] = await this.menuService.findChildMenus(id);

    // 删除这个菜单和子菜单
    await this.menuService.delete([id, ...ids]);
  }
}
