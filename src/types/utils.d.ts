type PropType<T, Path extends string> = string extends Path
  ? unknown
  : Path extends keyof T
    ? T[Path]
    : Path extends `${infer K}.${infer R}`
      ? K extends keyof T
        ? PropType<T[K], R>
        : unknown
      : unknown;

/**
 * @description 获取获取对象类型中的所有key，支持嵌套
 */
type GetKeyOfObject<ObjectType extends object> = {
  [Key in keyof ObjectType & (string | number)]: ObjectType[Key] extends object
    ? `${Key}` | `${Key}.${GetKeyOfObject<ObjectType[Key]>}`
    : `${Key}`;
}[keyof ObjectType & (string | number)];

type RecordNamePaths<T extends object> = {
  [K in GetKeyOfObject<T>]: PropType<T, K>;
};
