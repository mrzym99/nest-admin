import { Injectable } from '@nestjs/common';
import { Subscriber } from 'rxjs';
import { RoleEntity } from '../system/role/role.entity';
import { In } from 'typeorm';
import { UserEntity } from '../user/user.entity';

export interface MessageEvent {
  data?: string | number | object;
  id?: string;
  type?: 'ping' | 'close' | 'updatePermsAndMenus' | 'updateOnlineUsers';
  retry?: number;
}

const clientMap: Map<string, Subscriber<MessageEvent>[]> = new Map();

@Injectable()
export class SseService {
  /**
   * 添加客户端
   * @param uid 用户id
   * @param subscriber 订阅者
   */
  addClient(uid: string, subscriber: Subscriber<MessageEvent>) {
    const clients = clientMap.get(uid) || [];
    clientMap.set(uid, [...clients, subscriber]);
  }

  /**
   * 移除与关闭指定端的用户 （允许多端登录时）
   * @param uid 用户id
   * @param subscriber 订阅者
   */
  removeClient(uid: string, subscriber: Subscriber<MessageEvent>) {
    const clients = clientMap.get(uid) || [];
    const index = clients.findIndex((client) => client === subscriber);
    if (index > -1) {
      clients.splice(index, 1).at(0)?.complete();
    }
  }

  /**
   * 移除指定用户的连接
   * @param uid 用户id
   */
  removeClients(uid: string) {
    const clients = clientMap.get(uid) || [];
    clients.forEach((client) => client?.complete());
    clientMap.delete(uid);
  }

  /**
   * 发送消息给指定用户
   * @param uid 用户id
   * @param data 消息内容
   */
  sendToClients(uid: string, data: MessageEvent) {
    const clients = clientMap.get(uid) || [];
    clients.forEach((client) => client?.next?.(data));
  }

  /**
   * 发送消息给所有用户
   * @param data 消息内容
   */
  sendToAllClients(data: MessageEvent) {
    clientMap.forEach((clients) =>
      clients.forEach((client) => client?.next?.(data)),
    );
  }

  /**
   * 通知客户端更新菜单
   * @param uid 用户id / 用户ids
   */
  notifyClientToUpdateMenusByUserId(uid: string | string[]) {
    const userIds = [].concat(uid) as string[];
    userIds.forEach((uid) => {
      this.sendToClients(uid, {
        type: 'updatePermsAndMenus',
      });
    });
  }

  /**
   * 当这些菜单有变化时 通知客户端更新菜单
   * @param menuIds 菜单ids
   */
  async noticeClientToUpdateMenusByMenuIds(menuIds: string[]) {
    const roleMenus = await RoleEntity.find({
      where: {
        menus: {
          id: In(menuIds),
        },
      },
    });
    const roleIds = roleMenus.map((item) => item.id);
    await this.noticeClientToUpdateMenusByRoleIds(roleIds);
  }

  /**
   * 当这些角色有变化时 通知客户端更新菜单
   * @param roleIds 角色ids
   */
  async noticeClientToUpdateMenusByRoleIds(roleIds: string[]) {
    const users = await UserEntity.find({
      where: {
        roles: {
          id: In(roleIds),
        },
      },
    });

    if (users && users.length) {
      const userIds = users.map((item) => item.id);
      await this.notifyClientToUpdateMenusByUserId(userIds);
    }
  }
}
