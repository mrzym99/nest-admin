export class Pagination<PaginationObject> {
  constructor(
    public readonly list: PaginationObject[],

    public readonly currentPage: number,
    public readonly pageSize: number,
    public readonly total: number,
  ) {}
}
