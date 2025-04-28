import {
  Body,
  Controller,
  Delete,
  Get,
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
  UserResetPasswordDto,
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
import { ParamId } from '~/common/decorators/param-id.decorator';
import * as argon2 from 'argon2';

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
    await this.userService.checkUserExist(user.username, user.email);
    const { password } = user;
    user.password = await argon2.hash(password);
    await this.userService.create(user);
  }

  @Put('update/:id')
  @ApiOperation({ summary: '修改用户信息' })
  @Perm(permissions.UPDATE)
  async update(
    @ParamId() id: number,
    @Body() user: UserUpdateDto,
  ): Promise<void> {
    await this.userService.update(id, user);
  }

  @Put('updatePassword/:id')
  @ApiOperation({ summary: '修改用户密码' })
  async updatePassword(
    @ParamId() id: number,
    @Body() passwordDto: UserPasswordDto,
  ): Promise<void> {
    await this.userService.updatePassword(id, passwordDto);
  }

  @Put('resetPassword/:id')
  @ApiOperation({ summary: '重置用户密码' })
  @Perm(permissions.PASSWORD_RESET)
  async resetPassword(
    @ParamId() id: number,
    @Body() resetPasswordDto: UserResetPasswordDto,
  ): Promise<void> {
    await this.userService.resetPassword(id, resetPasswordDto);
  }

  @Put('updateProfile/:id')
  @ApiOperation({ summary: '修改用户详细信息' })
  @Perm(permissions.UPDATE)
  async updateProfile(
    @ParamId() id: number,
    @Body() profile: UserProfileDto,
  ): Promise<void> {
    await this.userService.updateProfile(id, profile);
  }

  @Get('profile/:id')
  @ApiOperation({ summary: '查询用户详细信息' })
  @ApiResult({ type: ProfileEntity })
  @Perm(permissions.READ)
  async userProfile(@ParamId() id: number) {
    return await this.userService.findUserProfile(id);
  }

  @Put('updateStatus')
  @ApiOperation({ summary: '修改用户状态' })
  @Perm(permissions.UPDATE)
  async updateStatus(@Body() dto: UserStatusDto): Promise<void> {
    await this.userService.batchUpdateStatus(dto);
  }

  @Delete('delete/:id')
  @ApiOperation({ summary: '删除用户' })
  @Perm(permissions.DELETE)
  async delete(@ParamId() id: number): Promise<void> {
    await this.userService.delete(id);
  }
}
