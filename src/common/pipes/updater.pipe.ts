import { Inject, Injectable, PipeTransform } from '@nestjs/common';
import { REQUEST } from '@nestjs/core';

export class UpdaterPip implements PipeTransform {
  constructor(@Inject(REQUEST) private request: any) {}
  transform(value: any) {
    const user = this.request.user as IAuthUser;

    value.updatedBy = user.uid;

    return value;
  }
}
