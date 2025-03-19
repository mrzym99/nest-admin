import { Inject, Injectable, PipeTransform } from '@nestjs/common';
import { REQUEST } from '@nestjs/core';

@Injectable()
export class CreatorPipe implements PipeTransform {
  constructor(@Inject(REQUEST) private request: any) {}
  transform(value: any) {
    const user = this.request.user as IAuthUser;

    value.createdBy = user.uid;

    return value;
  }
}
