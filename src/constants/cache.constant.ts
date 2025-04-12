export const API_CACHE_PREFIX = 'api-cache';

export enum RedisKey {
  AccessIp = 'access-ip',
  CAPTCHA_IMG_PREFIX = 'captcha:img:',
  AUTH_TOKEN_PREFIX = 'auth:token:',
  AUTH_PERM_PREFIX = 'auth:permission:',
  ONLINE_USER_PREFIX = 'online:user:',
  TOKEN_BLACKLIST_PREFIX = 'token:blacklist:',
  FORCED_OFFLINE_PREFIX = 'forced:offline:',
}
