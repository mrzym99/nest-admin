import { MenuType } from '~/modules/system/menu/dto/create-menu.dto';
import { MenuEntity } from '~/modules/system/menu/menu.entity';

export const filterMenuToTable = (
  menus: MenuEntity[],
  parentMenu: MenuEntity,
) => {
  const res = [];
  menus.forEach((menu) => {
    let realMenu;
    if (
      !parentMenu &&
      !menu.parentId &&
      [MenuType.DIRECTORY, MenuType.MENU].includes(menu.type)
    ) {
      const childMenu = filterMenuToTable(menus, menu);
      realMenu = { ...menu };
      realMenu.children = childMenu;
    } else if (
      parentMenu &&
      parentMenu.id === menu.parentId &&
      [MenuType.DIRECTORY, MenuType.MENU].includes(menu.type)
    ) {
      // 子菜单下继续找是否有子菜单
      const childMenu = filterMenuToTable(menus, menu);
      realMenu = { ...menu };
      realMenu.children = childMenu;
    } else if (
      parentMenu &&
      parentMenu.id === menu.parentId &&
      menu.type === MenuType.PERMISSION
    ) {
      realMenu = { ...menu };
    }

    if (realMenu) {
      realMenu.parentId = parentMenu ? parentMenu.id : '';
      res.push(realMenu);
    }
  });

  return res;
};

export const generateMenu = (menus: MenuEntity[]) => {
  return filterMenuToTable(menus, null);
};
