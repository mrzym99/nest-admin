import { RedisKey } from '~/constants/cache.constant';

/** 生成验证码 redis key */
export function genCaptchaImgKey(val: string | number) {
  return `${RedisKey.CAPTCHA_IMG_PREFIX}${String(val)}` as const;
}

/**
 * 生成token的 redis key
 * @param uid 用户id
 */
export function genAuthTokenKey(uid: number) {
  return `${RedisKey.AUTH_TOKEN_PREFIX}${uid}` as const;
}

/**
 * 生成用户权限的 redis key
 * @param uid 用户id
 */
export function genAuthPermKey(uid: number) {
  return `${RedisKey.AUTH_PERM_PREFIX}${uid}` as const;
}

/**
 * 生成在线用户的 redis key
 * @param tokenId tokenId
 */
export function genOnlineUserKey(tokenId: number | string) {
  return `${RedisKey.ONLINE_USER_PREFIX}${tokenId}` as const;
}

/**
 * 生成token黑名单的 redis key
 * @param token token
 */
export function genTokenBlacklistKey(token: string) {
  return `${RedisKey.TOKEN_BLACKLIST_PREFIX}${token}` as const;
}

/**
 * 生成被强制下线的 redis key
 * @param uid uid
 */
export function genForcedOfflineKey(uid: number) {
  return `${RedisKey.FORCED_OFFLINE_PREFIX}${uid}` as const;
}
