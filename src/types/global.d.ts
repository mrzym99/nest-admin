declare global {
  interface IAuthUser {
    uid: number;
    roles?: string[];
    exp?: number;
  }
}

export {};
