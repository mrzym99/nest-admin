import * as CryptoJS from 'crypto-js';

const key = CryptoJS.enc.Utf8.parse('nest-admin-0123456789');
const iv = CryptoJS.enc.Utf8.parse('0123456789-nest-admin');

export function aesEncrypt(data) {
  if (!data) return data;
  const enc = CryptoJS.AES.encrypt(data, key, {
    iv,
    mode: CryptoJS.mode.CBC,
    padding: CryptoJS.pad.Pkcs7,
  });
  return enc.toString();
}

export function aesDecrypt(data) {
  if (!data) return data;
  const dec = CryptoJS.AES.decrypt(data, key, {
    iv,
    mode: CryptoJS.mode.CBC,
    padding: CryptoJS.pad.Pkcs7,
  });
  return dec.toString(CryptoJS.enc.Utf8);
}

export function md5(str: string) {
  return CryptoJS.MD5(str).toString();
}
