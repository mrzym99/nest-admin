// 权限公开的key
export const PUBLIC_KEY = '__public_key__';

export const PERMISSION_KEY = '__permission_key__';

export const RESOURCE_KEY = '__resource_key__';

// 允许匿名访问的key
export const ALLOW_ANON_KEY = '__allow-anon_permission_key__';

export const AuthStrategy = {
  JWT: 'jwt',
  LOCAL: 'local',

  GOOGLE: 'google',
  FACEBOOK: 'facebook',
  GITHUB: 'github',
  QQ: 'qq',
};

export const Roles = {
  SUPER_ADMIN: 'super-admin',
  ADMIN: 'admin',
  USER: 'user',
} as const;
