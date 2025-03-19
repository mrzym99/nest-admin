import { Inject, Injectable, PipeTransform } from '@nestjs/common';
import { REQUEST } from '@nestjs/core';

@Injectable()
export class Updater implements PipeTransform {
  constructor(@Inject(REQUEST) private request: any) {}
  transform(value: any) {
    const user = this.request.user as IAuthUser;

    value.updateBy = user.uid;

    return value;
  }
}
