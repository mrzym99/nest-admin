import { OmitType, PartialType, PickType } from '@nestjs/swagger';
import { MenuEntity } from '~/modules/system/menu/menu.entity';

export class MenuMeta extends PartialType(
  OmitType(MenuEntity, [
    'id',
    'parentId',
    'roles',
    'path',
    'name',
    'createdAt',
    'updatedAt',
  ] as const),
) {
  title: string;
}

export class AccountMenus extends PickType(MenuEntity, [
  'id',
  'name',
  'path',
  'component',
] as const) {
  meta: MenuMeta;
}
