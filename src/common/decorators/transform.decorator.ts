import { Transform } from 'class-transformer';

export function ToNumber(defaultValue?: number) {
  return Transform(({ value }) => {
    return value ? Number(value) : defaultValue ?? null;
  });
}

export function ToDate(defaultValue?: Date) {
  return Transform(({ value }) => {
    return value ? new Date(value) : defaultValue ?? null;
  });
}
