import { MenuEntity } from './menu.entity';
import { ApiProperty } from '@nestjs/swagger';

export class MenuModel extends MenuEntity {
  @ApiProperty({ type: [MenuModel], description: '子菜单' })
  children: MenuModel[];
}

export class MenuInfoModel extends MenuEntity {
  @ApiProperty({ type: [MenuInfoModel], description: '父级菜单信息' })
  parent: any;
}
