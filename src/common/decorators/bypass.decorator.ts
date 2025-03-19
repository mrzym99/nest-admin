import { SetMetadata } from '@nestjs/common';

export const BYPASS_KEY = Symbol('__bypass__');

/**
 * @description
 * This decorator can be used to bypass the permission check for a specific route.
 * 当不需要对返回结果进行包装时 使用这个方法即可
 * @docsCategory common
 */
export function Bypass() {
  return SetMetadata(BYPASS_KEY, true);
}
