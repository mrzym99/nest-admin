import { Transform } from 'class-transformer';
import { isNil } from 'lodash';

export function ToNumber(defaultValue?: number) {
  return Transform(({ value }) => {
    return !isNil(value) ? Number(value) : (defaultValue ?? null);
  });
}

export function ToDate(defaultValue?: Date) {
  return Transform(({ value }) => {
    return !isNil(value) ? new Date(value) : (defaultValue ?? null);
  });
}
