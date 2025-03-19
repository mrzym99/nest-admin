// 是否开发环境
export const isDev = process.env.NODE_ENV === 'development';

// 当前工作目录
export const cwd = process.cwd();

// 基础类型
export type BaseType = boolean | number | string | null | undefined;

function formateValue<T extends BaseType = string>(
  key: string,
  defaultValue: T,
  callback?: (value: string) => T,
): T {
  const value: string | undefined = process.env[key];

  if (typeof value === 'undefined') {
    return defaultValue;
  }

  if (!callback) return value as T;

  return callback(value);
}
export function env(key: string, defaultValue: string = '') {
  return formateValue(key, defaultValue);
}

export function envString(key: string, defaultValue: string = '') {
  return formateValue(key, defaultValue);
}

export function envNumber(key: string, defaultValue: number = 0) {
  return formateValue(key, defaultValue, (value) => {
    try {
      return Number(value);
    } catch {
      throw new Error(`${value} is not a number`);
    }
  });
}

export function envBoolean(key: string, defaultValue: boolean = false) {
  return formateValue(key, defaultValue, (value) => {
    try {
      return Boolean(value);
    } catch {
      throw new Error(`${value} is not a boolean`);
    }
  });
}
