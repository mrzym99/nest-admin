import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Between, In, Like, Repository } from 'typeorm';

import { paginateRaw } from '~/helper/pagination';
import { PaginationTypeEnum } from '~/helper/pagination/interface';
import { Pagination } from '~/helper/pagination/pagination';
import { Storage } from '~/modules/tools/storage/storage.entity';
import { UserEntity } from '~/modules/user/user.entity';
import { deleteFile } from '~/utils';

import { StoragePageDto } from './storage.dto';
import { StorageInfo } from './storage.modal';
import { isEmpty } from 'lodash';

@Injectable()
export class StorageService {
  constructor(
    @InjectRepository(Storage)
    private storageRepository: Repository<Storage>,
    @InjectRepository(UserEntity)
    private userRepository: Repository<UserEntity>,
  ) {}

  /**
   * 删除文件
   */
  async delete(fileIds: number[]): Promise<void> {
    const items = await this.storageRepository.findBy({
      id: In(fileIds),
    });
    await this.storageRepository.delete(fileIds);

    items.forEach((el) => {
      deleteFile(el.path);
    });
  }

  /**
   * 删除文件
   */
  async deleteFilesByFileName(fileNames: string[]): Promise<void> {
    const items = await this.storageRepository.findBy({
      name: In(fileNames),
    });

    if (isEmpty(items)) return;
    await this.storageRepository.delete(items.map((el) => el.id));

    items.forEach((el) => {
      deleteFile(el.path);
    });
  }

  async list({
    currentPage,
    pageSize,
    name,
    type,
    size,
    extName,
    time,
    username,
  }: StoragePageDto): Promise<Pagination<StorageInfo>> {
    let user = null;
    if (username) {
      user = await this.userRepository.findOneBy({
        username,
      });
      if (!user) throw new BadRequestException('用户不存在');
    }
    const queryBuilder = this.storageRepository
      .createQueryBuilder('storage')
      .leftJoinAndSelect('user', 'user', 'storage.user_id = user.id')
      .where({
        ...(name && { name: Like(`%${name}%`) }),
        ...(type && { type }),
        ...(extName && { extName }),
        ...(size && { size: Between(size[0], size[1]) }),
        ...(time &&
          time.length > 1 && {
            createdAt: Between(
              new Date(parseInt(time[0])),
              new Date(parseInt(time[1])),
            ),
          }),
        ...(username && {
          userId: user.id,
        }),
      })
      .orderBy('storage.created_at', 'DESC');

    const { list, ...rest } = await paginateRaw<Storage>(queryBuilder, {
      currentPage,
      pageSize,
      paginationType: PaginationTypeEnum.LIMIT_AND_OFFSET,
    });

    function formatResult(result: Storage[]) {
      return result.map((e: any) => {
        return {
          id: e.storage_id,
          name: e.storage_name,
          extName: e.storage_ext_name,
          path: e.storage_path,
          type: e.storage_type,
          size: e.storage_size,
          createdAt: e.storage_created_at,
          username: e.user_username,
        };
      });
    }

    return {
      list: formatResult(list),
      ...rest,
    };
  }
}
