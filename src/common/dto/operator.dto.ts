import { ApiHideProperty } from '@nestjs/swagger';
import { Exclude, Expose } from 'class-transformer';

export class OperatorDto {
  @ApiHideProperty()
  @Exclude()
  @Expose()
  createdBy: string;

  @ApiHideProperty()
  @Exclude()
  @Expose()
  updatedBy: string;
}
