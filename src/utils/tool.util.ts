/**
 * 错误码处理
 * @param error 错误信息
 */
export const splitError = (error: string): [number, string] => {
  const errArr = error.split(':');

  return errArr.length > 1 ? [Number(errArr[0]), errArr[1]] : [500, error];
};

/**
 * 判断路由是否外链
 * @param path 路径
 */
export function isExternal(path: string): boolean {
  return /^(https?:\/\/|ftp:\/\/|mailto:|tel:)/i.test(path);
}
export const uniqueSlash = (path: string): string => {
  // $1 表示匹配到 https?:/
  // $2 表示匹配到 /
  // 所以他们连在一起就会把匹配到的 替换成 https?:// 或者是/
  return path.replace(/(https?:\/)|(\/)+/g, '$1$2');
};

/**
 * 排除一些对象的属性
 * @param data 原对象
 * @param fields 排除的列表
 */
export const excludeFields = (data: any, fields: string[]) => {
  const newData = { ...data };
  fields.forEach((field) => {
    delete newData[field];
  });
  return newData;
};

/**
 * 生成一个随机的值
 */
export function randomValue(
  size = 16,
  dict = 'useandom-26T198340PX75pxJACKVERYMINDBUSHWOLF_GQZbfghjklqvwyzrict',
): string {
  let id = '';
  let i = size;
  const len = dict.length;
  while (i--) id += dict[(Math.random() * len) | 0];
  return id;
}

export const hashString = function (str, seed = 0) {
  let h1 = 0xdeadbeef ^ seed;
  let h2 = 0x41c6ce57 ^ seed;
  for (let i = 0, ch; i < str.length; i++) {
    ch = str.charCodeAt(i);
    h1 = Math.imul(h1 ^ ch, 2654435761);
    h2 = Math.imul(h2 ^ ch, 1597334677);
  }
  h1 =
    Math.imul(h1 ^ (h1 >>> 16), 2246822507) ^
    Math.imul(h2 ^ (h2 >>> 13), 3266489909);
  h2 =
    Math.imul(h2 ^ (h2 >>> 16), 2246822507) ^
    Math.imul(h1 ^ (h1 >>> 13), 3266489909);
  return 4294967296 * (2097151 & h2) + (h1 >>> 0);
};
