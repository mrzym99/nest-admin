import * as fs from 'node:fs';
import * as path from 'node:path';

import * as dayjs from 'dayjs';
import * as multer from 'multer';

enum Type {
  IMAGE = 'image',
  TXT = 'txt',
  MUSIC = 'music',
  VIDEO = 'video',
  OTHER = 'other',
}

export function getFileType(extName: string) {
  const documents = 'txt doc pdf ppt pps xlsx xls docx';
  const music = 'mp3 wav wma mpa ram ra aac aif m4a';
  const video = 'avi mpg mpe mpeg asf wmv mov qt rm mp4 flv m4v webm ogv ogg';
  const image =
    'bmp dib pcp dif wmf gif jpg tif eps psd cdr iff tga pcd mpt png jpeg';
  if (image.includes(extName)) return Type.IMAGE;

  if (documents.includes(extName)) return Type.TXT;

  if (music.includes(extName)) return Type.MUSIC;

  if (video.includes(extName)) return Type.VIDEO;

  return Type.OTHER;
}

export function getFileName(fileName: string) {
  if (fileName.includes('.')) return fileName.split('.')[0];

  return fileName;
}

export function getExtname(fileName: string) {
  return path.extname(fileName).replace('.', '');
}

export function getSize(bytes: number, decimals = 2) {
  if (bytes === 0) return '0 Bytes';

  const k = 1024;
  const dm = decimals < 0 ? 0 : decimals;
  const sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

  const i = Math.floor(Math.log(bytes) / Math.log(k));

  return `${Number.parseFloat((bytes / k ** i).toFixed(dm))} ${sizes[i]}`;
}

export function getFilePath(name: string, currentDate: string, type: string) {
  return `/upload/${currentDate}/${type}/${name}`;
}

export async function deleteFile(name: string) {
  fs.unlink(path.join(__dirname, '../../', 'public', name), () => {
    // console.log(error);
  });
}

export function genFileName(name: string) {
  return Date.now() + '-' + name;
}

/**
 * 文件上传 https://github.com/expressjs/multer#multeropts
 * multer.diskStorage
 */
export const uploadLocalStorage = multer.diskStorage({
  destination: async (req, file, cb) => {
    const fileName = file.originalname;
    const extName = getExtname(fileName);
    const type = getFileType(extName);
    const currentDate = dayjs().format('YYYY-MM-DD');

    const folderPath = path.join(
      __dirname,
      '../../',
      `public/upload/${currentDate}/${type}/`,
    );

    try {
      // 判断是否有该文件夹
      await fs.promises.stat(folderPath);
    } catch (error) {
      // 没有该文件夹就创建
      await fs.promises.mkdir(folderPath, { recursive: true });
    }

    cb(null, folderPath);
  },
  filename: (req, file, cb) => {
    cb(null, genFileName(file.originalname));
  },
});
