import { Injectable } from '@nestjs/common';
import Redis from 'ioredis';
import { InjectRedis } from '~/common/decorators/inject-redis.decorator';
import { BusinessException } from '~/common/exceptions/biz.exception';
import { ErrorEnum } from '~/constants/error.constant';
import { genOnlineUserKey } from '~/helper/gen-redis-key';
import { AuthService } from '~/modules/auth/auth.service';
import { AccessTokenEntity } from '~/modules/auth/entities/access-token.entity';
import { TokenService } from '~/modules/auth/services/token.service';
import { UserService } from '~/modules/user/user.service';
import { OnlineUser } from './online.model';
import { OnlineQueryDto } from './online.dto';
import { Pagination } from '~/helper/pagination/pagination';
import { UAParser } from 'ua-parser-js';
import { getIpAddress } from '~/utils';
import { UserEntity } from '~/modules/user/user.entity';
import { SseService } from '~/modules/sse/sse.service';
import { throttle, isEmpty } from 'lodash';
import { createPaginationObject } from '~/helper/pagination/create-pagination';

@Injectable()
export class OnlineService {
  constructor(
    @InjectRedis() private readonly redis: Redis,
    private readonly userService: UserService,
    private readonly authService: AuthService,
    private readonly tokenService: TokenService,
    private readonly sseService: SseService,
  ) {}

  /**
   * 通知前端刷新在线用户列表 增加了防抖 避免频繁
   * @returns
   */
  notifyUpdateOnlineUsers = throttle(() => {
    this.sseService.sendToAllClients({
      type: 'updateOnlineUsers',
    });
  }, 3000);

  /**
   * 添加在线用户
   * @param value token
   * @param ip ip
   * @param ua ua
   */
  async addOnlineUser(value: string, ip: string, ua: string): Promise<void> {
    const token = await AccessTokenEntity.findOne({
      where: {
        value,
      },
      relations: ['user'],
      cache: true,
    });

    if (!token) return;

    const payload = await this.tokenService.verifyAccessToken(value);

    const exp = ~~(payload.exp - Date.now() / 1000); // ~~ 等价 Math.floor

    const pager = new UAParser();
    const uaResult = pager.setUA(ua).getResult();
    const address = await getIpAddress(ip);

    let userInfo: UserEntity;
    if (token.user) {
      // 获取用户详细信息
      userInfo = await this.userService.findUserInfo(token.user.id);
    }

    const result: OnlineUser = {
      ip,
      address,
      tokenId: token.id,
      uid: userInfo.id,
      username: userInfo.username,
      nickName: userInfo.profile?.nickName || '',
      deptName: userInfo.dept?.name ?? '',
      os: `${uaResult.os.name ?? ''} ${uaResult.os.version}`,
      browser: uaResult.browser.name,
      time: token.createdAt.toString(),
    };

    await this.redis.set(
      genOnlineUserKey(token.id),
      JSON.stringify(result),
      'EX',
      exp,
    );
    await this.notifyUpdateOnlineUsers();
  }

  /**
   * 指定的用户
   * @param token
   */
  async removeOnlineUser(value: string): Promise<void> {
    const token = await AccessTokenEntity.findOne({
      where: {
        value,
      },
      relations: ['user'],
      cache: true,
    });

    if (token) {
      await this.redis.del(genOnlineUserKey(token.id));
      await this.notifyUpdateOnlineUsers();
    }
  }

  /**
   * 清空所有在线用户
   */
  async clearAllOnlineUsers(): Promise<void> {
    const keys = await this.redis.get(genOnlineUserKey('*'));
    await this.redis.del(keys);
  }

  /**
   * 分页获取在线用户列表
   * @param 查询参数
   * @param value
   */
  async list(
    { currentPage, pageSize, username, nickName }: OnlineQueryDto,
    value: string,
  ): Promise<Pagination<OnlineUser>> {
    const token = await AccessTokenEntity.findOne({
      where: {
        value,
      },
      relations: ['user'],
      cache: true,
    });

    // 获取所有在线用户的key
    const keys = await this.redis.keys(genOnlineUserKey('*'));

    let list = [],
      total = 0;
    if (!isEmpty(keys)) {
      // 获取所有在线用户的value
      const users = await this.redis.mget(keys);

      const onlineUsers = await Promise.all(
        users
          .filter((u) => u) // 可能存在 [ null ] 的情况
          .map(async (u) => {
            const item = JSON.parse(u) as OnlineUser;
            item.isCurrentUser = token ? item.tokenId === token.id : false;
            item.disabled = await this.userService.isAdmin(item.uid);
            return item;
          }),
      );

      // 过滤用户
      const filteredUsers = onlineUsers.filter(
        (u) =>
          (username ? u.username.includes(username) : true) &&
          (nickName ? u.nickName.includes(nickName) : true),
      );

      const start = (currentPage - 1) * pageSize;
      const end = start + pageSize - 1;

      list = filteredUsers
        .slice(start, end)
        .sort((a, b) => (a.time > b.time ? -1 : 1));

      total = filteredUsers.length;
    }

    return createPaginationObject({
      list,
      currentPage,
      pageSize,
      total,
    });
  }

  /**
   * 获取在线用户总数
   * @returns
   */
  async total(): Promise<number> {
    const keys = await this.redis.keys(genOnlineUserKey('*'));
    return keys.length;
  }

  /**
   * 下线指定用户
   * @param tokenId tokenId
   * @param user 当前操作人
   */
  async kick(tokenId: string, user: IAuthUser): Promise<void> {
    const token = await AccessTokenEntity.findOne({
      where: {
        id: tokenId,
      },
      relations: ['user'],
      cache: true,
    });

    if (!token) return;

    const targetUid = token.user.id;
    const isAdmin = await this.userService.isAdmin(user.uid);
    const targetIsAdmin = await this.userService.isAdmin(targetUid);
    // 普通用户无法下线其他用户
    if (!isAdmin) {
      throw new BusinessException(ErrorEnum.AUTH_NOT_ALLOWED_TO_LOGOUT_USER);
    }
    // 管理员是不能被下线的

    if (targetIsAdmin) {
      throw new BusinessException(ErrorEnum.AUTH_NOT_ALLOWED_TO_LOGOUT_ADMIN);
    }

    const targetUser = await this.tokenService.verifyAccessToken(token.value);
    await this.authService.clearLoginStatus(token.value, targetUser);
    await this.notifyUpdateOnlineUsers();
  }
}
