import { SetMetadata } from '@nestjs/common';
import { PUBLIC_KEY } from '../auth.constant';

/**
 * 当接口不需要登录时 使用该装饰器
 */
export const Public = () => SetMetadata(PUBLIC_KEY, true);
