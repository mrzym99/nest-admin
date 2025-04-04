import {
  Body,
  Controller,
  Get,
  Param,
  Post,
  Put,
  Query,
  // UseGuards,
} from '@nestjs/common';
import { UserService } from './user.service';
import {
  UserCreateDto,
  UserPasswordDto,
  UserProfileDto,
  UserQueryDto,
  UserStatusDto,
  UserUpdateDto,
} from './dto/user.dto';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { ApiResult } from '~/common/decorators/api-result.decorator';
import { ProfileEntity } from './profile.entity';
// import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { UserInfo } from './user.model';
import {
  definePermission,
  Perm,
} from '../auth/decorators/permission.decorator';

export const permissions = definePermission('system:user', {
  LIST: 'list',
  CREATE: 'create',
  READ: 'read',
  UPDATE: 'update',
  DELETE: 'delete',

  PASSWORD_RESET: 'pass:reset',
} as const);

@ApiSecurityAuth()
@ApiTags('System - 用户模块')
@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Get('list')
  @ApiOperation({ summary: '分页获取用户列表' })
  @ApiResult({ type: [UserInfo], isPage: true })
  @ApiResponse({ type: UserInfo })
  // @UseGuards(JwtAuthGuard)
  @Perm(permissions.LIST)
  async list(@Query() dto: UserQueryDto) {
    return await this.userService.list(dto);
  }

  @Post('create')
  @ApiOperation({ summary: '创建用户' })
  @Perm(permissions.CREATE)
  async create(@Body() user: UserCreateDto): Promise<void> {
    await this.userService.create(user);
  }

  @Put('update/:id')
  @ApiOperation({ summary: '修改用户角色、部门信息' }) // 主要是修改部门和角色信息
  @Perm(permissions.UPDATE)
  async update(
    @Param('id') id: string,
    @Body() user: UserUpdateDto,
  ): Promise<void> {
    await this.userService.update(id, user);
  }

  @Put('updatePassword/:id')
  @ApiOperation({ summary: '修改用户密码' })
  async updatePassword(
    @Param('id') id: string,
    @Body() passwordDto: UserPasswordDto,
  ): Promise<void> {
    await this.userService.updatePassword(id, passwordDto);
  }

  @Put('resetPassword/:id')
  @ApiOperation({ summary: '重置用户密码' })
  @Perm(permissions.PASSWORD_RESET)
  async resetPassword(@Param('id') id: string): Promise<void> {
    await this.userService.resetPassword(id);
  }

  @Put('updateProfile/:id')
  @ApiOperation({ summary: '修改用户详细信息' })
  @Perm(permissions.UPDATE)
  async updateProfile(
    @Param('id') id: string,
    @Body() profile: UserProfileDto,
  ): Promise<void> {
    await this.userService.updateProfile(id, profile);
  }

  @Get('profile/:id')
  @ApiOperation({ summary: '查询用户详细信息' })
  @ApiResult({ type: ProfileEntity })
  @Perm(permissions.READ)
  async userProfile(@Param('id') id: string) {
    return await this.userService.findUserProfile(id);
  }

  @Put('updateStatus')
  @ApiOperation({ summary: '修改用户状态' })
  @Perm(permissions.UPDATE)
  async updateStatus(@Query() dto: UserStatusDto): Promise<void> {
    await this.userService.batchUpdateStatus(dto);
  }
}
