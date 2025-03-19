import { applyDecorators, SetMetadata } from '@nestjs/common';
import { PERMISSION_KEY } from '../auth.constant';
import { isPlainObject } from 'lodash';
export function Perm(permission: string | string[]) {
  return applyDecorators(SetMetadata(PERMISSION_KEY, permission));
}

// 权限列表
let permissions: string[] = [];

/**
 * 定义权限，同时收集所有被定义的权限
 *
 * - 通过对象形式定义, eg:
 * ```ts
 * definePermission('app:health', {
 *  NETWORK: 'network'
 * };
 * ```
 *
 * - 通过字符串数组形式定义, eg:
 * ```ts
 * definePermission('app:health', ['network']);
 * ```
 */
export function definePermission<
  T extends string,
  U extends Record<string, string>,
>(modulePrefix: T, actionMap: U): AddPrefixToObjectValue<T, U>;
export function definePermission<
  T extends string,
  U extends ReadonlyArray<string>,
>(modulePrefix: T, actions: U): TupleToObject<T, U>;
export function definePermission(modulePrefix: string, actions) {
  if (isPlainObject(actions)) {
    Object.entries(actions).forEach(([key, action]) => {
      actions[key] = `${modulePrefix}:${action}`;
    });
    permissions = [
      ...new Set([...permissions, ...Object.values<string>(actions)]),
    ];

    return actions;
  } else if (Array.isArray(actions)) {
    const permissionFormat = actions.map(
      (action) => `${modulePrefix}:${action}`,
    );
    permissions = [...new Set([...permissions, ...permissionFormat])];

    return actions.reduce((prev, action) => {
      prev[action.toUpperCase()] = `${modulePrefix}:${action}`;
      return prev;
    }, {});
  }
}

/* 获取所有被定义的权限 */
export function getDefinePermissions() {
  return permissions;
}

type AddPrefixToObjectValue<
  T extends string,
  P extends Record<string, string>,
> = {
  [K in keyof P]: K extends string ? `${T}:${P[K]}` : never;
};

type TupleToObject<T extends string, P extends ReadonlyArray<string>> = {
  [K in Uppercase<P[number]>]: `${T}:${Lowercase<K>}`;
};
