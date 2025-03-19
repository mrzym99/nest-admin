import { Body, Controller, Get, Post, Query, Req } from '@nestjs/common';
import { OnlineService } from './online.service';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { ApiResult } from '~/common/decorators/api-result.decorator';
import { OnlineUser } from './online.model';
import { KickDto, OnlineQueryDto } from './online.dto';
import { AuthUser } from '~/modules/auth/decorators/auth-user.decorator';
import { Pagination } from '~/helper/pagination/pagination';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';

export const permissions = definePermission('system:online', [
  'list',
  'kick',
] as const);

@ApiSecurityAuth()
@ApiTags('System - 在线用户模块')
@Controller('online')
export class OnlineController {
  constructor(private readonly onlineService: OnlineService) {}

  @Get('list')
  @ApiOperation({ summary: '查询在线用户列表' })
  @ApiResult({ type: [OnlineUser] })
  @Perm(permissions.LIST)
  async list(
    @Query() dto: OnlineQueryDto,
    @Req() req: ExpressRequest,
  ): Promise<Pagination<OnlineUser>> {
    return await this.onlineService.list(dto, req.accessToken);
  }

  @Get('total')
  @ApiOperation({ summary: '获取在线人数总数' })
  @ApiResult({ type: [Number] })
  async total(): Promise<Number> {
    return await this.onlineService.total();
  }

  @Post('kick') // kick 踢
  @ApiOperation({ summary: '强制下线指定用户' })
  @Perm(permissions.KICK)
  async kick(@Body() dto: KickDto, @AuthUser() user: IAuthUser): Promise<void> {
    await this.onlineService.kick(dto.tokenId, user);
  }
}
