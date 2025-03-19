import { ApiProperty, PartialType } from '@nestjs/swagger';
import {
  IsArray,
  IsBoolean,
  IsEnum,
  IsIn,
  IsInt,
  IsNumber,
  IsOptional,
  IsString,
  Min,
  MinLength,
  ValidateIf,
} from 'class-validator';
import { ToNumber } from '~/common/decorators/transform.decorator';

export enum MenuType {
  // 目录
  DIRECTORY = 0,
  // 菜单
  MENU = 1,
  // 权限
  PERMISSION = 2,
}

export enum IconType {
  ICONIFY = 0,
  LOCAL = 1,
}

export enum OpenMode {
  // 内部
  INNER = 1,
  // 新的窗口
  BLANK = 0,
}

export class MenuCreateDto {
  @ApiProperty({ description: '父级菜单id' })
  @IsOptional()
  @IsString()
  parentId?: string;

  @ApiProperty({ description: '菜单/权限名称' })
  @IsString()
  @IsOptional()
  @MinLength(2, { message: '菜单/权限名称不能小于2个字符' })
  title?: string;

  @ApiProperty({ description: '国际化key' })
  @IsString()
  @IsOptional()
  i18nKey?: string;

  @ApiProperty({ description: '路由名称' })
  @IsString()
  @IsOptional()
  name: string;

  @ApiProperty({ description: '路由路径' })
  @IsOptional()
  @IsString()
  @ValidateIf((o) => o.type !== MenuType.PERMISSION)
  path?: string;

  @ApiProperty({ description: '组件路径' })
  @IsOptional()
  @IsString()
  @ValidateIf((o) => o.type !== MenuType.PERMISSION)
  component?: string;

  @ApiProperty({ description: '权限' })
  @IsOptional()
  @IsString()
  @ValidateIf((o) => o.type === MenuType.PERMISSION)
  permission?: string;

  @ApiProperty({
    description: `
    菜单类型:
    - 0: 菜单
    - 1: 目录
    - 2: 权限   
    `,
    enum: MenuType,
  })
  @IsIn([MenuType.MENU, MenuType.DIRECTORY, MenuType.PERMISSION])
  type: MenuType;

  @ApiProperty({ description: '菜单图标' })
  @IsOptional()
  @IsString()
  @ValidateIf((o) => o.type !== MenuType.PERMISSION)
  icon?: string;

  @ApiProperty({ description: '菜单图标类型', enum: IconType })
  @IsOptional()
  @IsInt()
  @IsIn([IconType.ICONIFY, IconType.LOCAL])
  iconType?: number;

  @ApiProperty({ description: '菜单排序' })
  @IsInt()
  @IsOptional()
  @Min(0)
  order?: number;

  @ApiProperty({ description: '是否外链', default: false })
  @IsBoolean()
  @IsOptional()
  @ValidateIf((o) => o.type !== MenuType.PERMISSION)
  isExt?: boolean;

  @ApiProperty({ description: '外链打开模式', enum: OpenMode })
  @IsOptional()
  @IsEnum(OpenMode)
  @ValidateIf((o: MenuCreateDto) => o.isExt)
  extOpenMode?: number;

  @ApiProperty({ description: '外链地址', default: '' })
  @IsOptional()
  @ValidateIf((o: MenuCreateDto) => o.isExt)
  href?: string;

  @ApiProperty({ description: '是否缓存', default: false })
  @IsBoolean()
  @IsOptional()
  @ValidateIf((o: MenuCreateDto) => o.type === MenuType.MENU)
  keepAlive?: boolean;

  @ApiProperty({ description: '是否隐藏', default: false })
  @IsBoolean()
  @IsOptional()
  @ValidateIf((o) => o.type !== MenuType.PERMISSION)
  hideInMenu?: boolean;

  @ApiProperty({ description: '设置当前路由高亮的菜单项，一般用于详情页' })
  @IsString()
  @IsOptional()
  @ValidateIf((o) => o.type !== MenuType.PERMISSION)
  activeMenu?: string;

  @ApiProperty({ description: '多页签', default: false })
  @IsBoolean()
  @IsOptional()
  @ValidateIf((o) => o.type !== MenuType.PERMISSION)
  multiTab: boolean;

  @ApiProperty({ description: '固定页签的序号', default: null })
  @IsNumber()
  @IsOptional()
  @ValidateIf((o) => o.type !== MenuType.PERMISSION)
  fixedIndexInTab?: number;

  @ApiProperty({ description: '菜单状态', default: 1 })
  @IsIn([0, 1])
  @ToNumber()
  status: number;
}

export class MenuUpdateDto extends PartialType(MenuCreateDto) {}

export class MenuQueryDto {
  @ApiProperty({ description: '菜单名称' })
  @IsOptional()
  @IsString()
  title?: string;

  @ApiProperty({ description: '路由名称' })
  @IsOptional()
  @IsString()
  name?: string;

  @ApiProperty({ description: '路由地址' })
  @IsOptional()
  @IsString()
  path?: string;

  @ApiProperty({ description: '组件' })
  @IsOptional()
  @IsString()
  component?: string;

  @ApiProperty({ description: '权限' })
  @IsOptional()
  @IsString()
  permission?: string;

  @ApiProperty({ description: '菜单状态' })
  @IsOptional()
  @ToNumber()
  @IsIn([0, 1])
  status: number;
}

export class MenuStatusDto {
  @ApiProperty({
    description: '用户ID数组',
  })
  @IsArray()
  ids: string[];

  @ApiProperty({
    description: '状态',
  })
  @IsIn([0, 1])
  @ToNumber()
  status: number;
}
