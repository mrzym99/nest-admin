import 'fastify';

declare module 'fastify' {
  interface FastifyRequest {
    user?: IAuthUser;
    accessToken: string;
    file: any;
  }
}

declare module 'nestjs-cls' {
  interface ClsStore {
    /** 当前请求操作的 ID */
    operateId: number;
  }
}
