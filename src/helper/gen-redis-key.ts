import { RedisKey } from '~/constants/cache.constant';

/** 生成验证码 redis key */
export function genCaptchaImgKey(val: string | number) {
  return `${RedisKey.CAPTCHA_IMG_PREFIX}${String(val)}` as const;
}

/**
 * 生成token的 redis key
 * @param uid 用户id
 */
export function genAuthTokenKey(uid: string) {
  return `${RedisKey.AUTH_TOKEN_PREFIX}${uid}` as const;
}

/**
 * 生成用户权限的 redis key
 * @param uid 用户id
 */
export function genAuthPermKey(uid: string) {
  return `${RedisKey.AUTH_PERM_PREFIX}${uid}` as const;
}

/**
 * 生成在线用户的 redis key
 * @param tokenId tokenId
 */
export function genOnlineUserKey(tokenId: string) {
  return `${RedisKey.ONLINE_USER_PREFIX}${tokenId}` as const;
}

/**
 * 生成token黑名单的 redis key
 * @param tokenId tokenId
 */
export function genTokenBlacklistKey(tokenId: string) {
  return `${RedisKey.TOKEN_BLACKLIST_PREFIX}${tokenId}` as const;
}
