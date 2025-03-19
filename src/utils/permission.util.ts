import { MenuType } from '~/modules/system/menu/dto/create-menu.dto';
import { MenuEntity } from '~/modules/system/menu/menu.entity';
import { isExternal, uniqueSlash } from './tool.util';

export interface RouteRecordRaw {
  id: string;
  path: string;
  name: string;
  component?: string;
  redirect?: string;
  props?: {
    url?: string;
  };
  meta: {
    title: string;
    i18nKey?: string;
    icon?: string;
    iconType?: number;
    href?: string;
    type: number;
    order?: number;
    activeMenu?: string;
    status: number;
    keepAlive?: boolean;
    hideInMenu?: boolean;
    multiTab?: boolean;
    fixedIndexInTab?: number;
  };
  children?: RouteRecordRaw[];
}

function createRoute(menu: MenuEntity): RouteRecordRaw {
  const commonMeta: RouteRecordRaw['meta'] = {
    title: menu.title,
    i18nKey: menu.i18nKey,
    icon: menu.icon,
    iconType: menu.iconType,
    type: menu.type,
    order: menu.order,
    activeMenu: menu.activeMenu,
    status: menu.status,
    keepAlive: menu.keepAlive,
    hideInMenu: menu.hideInMenu,
    multiTab: menu.multiTab,
    fixedIndexInTab: menu.fixedIndexInTab,
  };

  // 外链
  if (menu.isExt) {
    if (menu.extOpenMode === 0) {
      return {
        id: menu.id,
        path: menu.path,
        name: menu.name,
        props: {
          url: menu.href,
        },
        meta: { ...commonMeta },
        component: menu.component,
      };
    } else {
      return {
        id: menu.id,
        path: menu.path,
        name: menu.name,
        meta: { ...commonMeta, ...{ href: menu.href } },
      };
    }
  }

  // 目录
  if (menu.type === MenuType.DIRECTORY) {
    return {
      id: menu.id,
      path: menu.path,
      name: menu.name,
      component: menu.component,
      meta: { ...commonMeta },
    };
  }

  return {
    id: menu.id,
    path: menu.path,
    name: menu.name,
    component: menu.component,
    meta: { ...commonMeta },
  };
}

function filterAsyncRoutes(
  menus: MenuEntity[],
  parentRoute: MenuEntity,
): RouteRecordRaw[] {
  const res: RouteRecordRaw[] = [];

  menus.forEach((menu) => {
    if (menu.type === MenuType.PERMISSION || !menu.status) return;

    let realRoute: RouteRecordRaw;

    const genFullPath = (path: string, parentPath) => {
      return uniqueSlash(
        path.startsWith('/') ? path : `/${parentPath}/${path}`,
      );
    };

    // 根菜单
    if (!parentRoute && !menu.parentId && menu.type === MenuType.MENU) {
      realRoute = createRoute(menu);
    } else if (
      !parentRoute &&
      !menu.parentId &&
      menu.type === MenuType.DIRECTORY
    ) {
      // 目录
      const childRoutes = filterAsyncRoutes(menus, menu);

      realRoute = createRoute(menu);
      if (childRoutes && childRoutes.length) {
        realRoute.redirect = genFullPath(childRoutes[0].path, realRoute.path);
        realRoute.children = childRoutes;
      }
    } else if (
      parentRoute &&
      parentRoute.id === menu.parentId &&
      menu.type === MenuType.MENU
    ) {
      // 子菜单
      realRoute = createRoute(menu);
    } else if (
      parentRoute &&
      parentRoute.id === menu.parentId &&
      menu.type === MenuType.DIRECTORY
    ) {
      const childRoutes = filterAsyncRoutes(menus, menu);
      realRoute = createRoute(menu);
      if (childRoutes && childRoutes.length) {
        realRoute.redirect = genFullPath(childRoutes[0].path, realRoute.path);
        realRoute.children = childRoutes;
      }
    }

    if (realRoute) res.push(realRoute);
  });

  return res;
}
export function generateRoutes(menus: MenuEntity[]) {
  return filterAsyncRoutes(menus, null);
}
