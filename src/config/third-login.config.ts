import { ConfigType, registerAs } from '@nestjs/config';
import { env } from '~/utils';

export const thirdLoginRegToken = 'thirdLogin';

export const ThirdLoginConfig = registerAs(thirdLoginRegToken, () => ({
  githubClientId: env('GITHUB_CLIENT_ID'),
  githubSecret: env('GITHUB_CLIENT_SECRET'),
  githubCallBackUrl: env('GITHUB_CALLBACK_URL'),
}));

export type IThirdLoginConfig = ConfigType<typeof ThirdLoginConfig>;
