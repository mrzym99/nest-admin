import { SetMetadata } from '@nestjs/common';
import { ALLOW_ANON_KEY } from '../auth.constant';

/**
 * 当不需要对接口进行权限检测即可调用接口时添加该装饰器 当然 前提是用户登录了
 */
export const AllowAnon = () => SetMetadata(ALLOW_ANON_KEY, true);
