import { Pagination } from './pagination';

export function createPaginationObject<T>({
  list,
  currentPage,
  pageSize,
  total,
}: {
  list: T[];
  currentPage: number;
  pageSize: number;
  total?: number;
}): Pagination<T> {
  return new Pagination<T>(list, currentPage, pageSize, total);
}
