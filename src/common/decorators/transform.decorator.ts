import { Transform } from 'class-transformer';

export function ToNumber(defaultValue?: number) {
  defaultValue = defaultValue || 0;
  return Transform(({ value }) => {
    return value ? Number(value) : defaultValue;
  });
}

export function ToDate(defaultValue?: Date) {
  return Transform(({ value }) => {
    return value ? new Date(value) : defaultValue;
  });
}
