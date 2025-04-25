import { ConfigType, registerAs } from '@nestjs/config';
import { env } from '~/utils';

export const payRegToken = 'pay';

export const PayConfig = registerAs(payRegToken, () => ({
  appId: env('PAY_APP_ID'),
  signType: env('PAY_SIGN_TYPE'),
  gateWay: env('PAY_GATEWAY'),
}));

export type IPayConfig = ConfigType<typeof PayConfig>;
