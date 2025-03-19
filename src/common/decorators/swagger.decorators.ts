import { applyDecorators } from '@nestjs/common';
import { ApiSecurity } from '@nestjs/swagger';

export const API_SECURITY_AUTH = 'Authorization';
export function ApiSecurityAuth() {
  return applyDecorators(ApiSecurity(API_SECURITY_AUTH));
}
