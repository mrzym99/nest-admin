export enum SocketEvents {
  CONNECT = 'SOCKET_CONNECT',
  DISCONNECT = 'SOCKET_DISCONNECT',
  CONNECT_ERROR = 'SOCKET_CONNECT_ERROR',
  CONNECT_TIMEOUT = 'SOCKET_TIMEOUT_ERROR',

  // 认证失败
  AUTH_FAILED = 'AUTH_FAILED',
  TokenExpired = 'token.expired',

  // 用户相关
  USER_ONLINE = 'USER_ONLINE',
  USER_OFFLINE = 'USER_OFFLINE',
  USER_KICK = 'USER_KICK',
}