import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import * as dayjs from 'dayjs';
import { isNil } from 'lodash';
import { Repository } from 'typeorm';
import { getExtname, getFilePath, getFileType, getSize } from '~/utils';
import { Storage } from '../storage/storage.entity';

@Injectable()
export class UploadService {
  constructor(
    @InjectRepository(Storage)
    private storageRepository: Repository<Storage>,
  ) {}

  async upload(file: Express.Multer.File, userId: string) {
    if (isNil(file))
      throw new NotFoundException('404:Have not any file to upload!');

    const fileName = file.originalname;
    const size = getSize(file.size);
    const extName = getExtname(fileName);
    const type = getFileType(extName);
    const name = file.filename;
    const currentDate = dayjs().format('YYYY-MM-DD');
    const path = getFilePath(name, currentDate, type);

    await this.storageRepository.save({
      name,
      fileName,
      extName,
      path,
      type,
      size,
      userId,
    });

    return path;
  }
}
