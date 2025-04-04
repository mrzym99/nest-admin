declare global {
  interface IAuthUser {
    uid: string;
    roles?: string[];
    exp?: number;
  }

  interface ExpressRequest {
    on(arg0: string, arg1: () => void): unknown;
    user?: IAuthUser;
    accessToken?: string;
    raw: any;
    method: string;
  }
}

export {};
