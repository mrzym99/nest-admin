import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DictItemEntity } from './dict-item.entity';
import { In, Like, Repository } from 'typeorm';
import {
  DictItemCreateDto,
  DictItemQueryDto,
  DictItemStatusDto,
  DictItemUpdateDto,
} from './dict-item.dto';
import { paginate } from '~/helper/pagination';
import { DictTypeEntity } from '../type/dict-type.entity';
import { isEmpty } from 'lodash';
import { BusinessException } from '~/common/exceptions/biz.exception';
import { ErrorEnum } from '~/constants/error.constant';

@Injectable()
export class DictItemService {
  constructor(
    @InjectRepository(DictItemEntity)
    private readonly dictItemRepository: Repository<DictItemEntity>,
  ) {}

  async list({
    currentPage,
    pageSize,
    label,
    value,
    typeId,
  }: DictItemQueryDto) {
    const queryBuilder = await this.dictItemRepository
      .createQueryBuilder('dict_item')
      .where({
        ...(label && { label: Like(`%${label}%`) }),
        ...(value && { value: Like(`%${value}%`) }),
        type: {
          id: typeId,
        },
      })
      .orderBy({ 'dict_item.order': 'ASC' });

    return await paginate<DictItemEntity>(queryBuilder, {
      currentPage,
      pageSize,
    });
  }

  async getDictItemListByTypeId(typeId: number) {
    return await this.dictItemRepository.find({
      where: {
        type: {
          id: typeId,
        },
        status: 1,
      },
      order: {
        order: 'ASC',
      },
    });
  }

  async validateDelete(typeId: number) {
    const exist = await this.dictItemRepository.find({
      where: {
        type: {
          id: typeId,
        },
      },
    });

    if (!isEmpty(exist))
      throw new BusinessException(ErrorEnum.DICT_TYPE_HAS_CHILDREN);
  }

  async create(dto: DictItemCreateDto) {
    const item = await this.dictItemRepository.findOne({
      where: {
        value: dto.value,
        type: {
          id: dto.typeId,
        },
      },
    });

    if (item) throw new BusinessException(ErrorEnum.DICT_ITEM_EXIST);
    const { typeId, ...rest } = dto;
    await this.dictItemRepository.save({
      ...rest,
      type: await DictTypeEntity.findOneBy({
        id: typeId,
      }),
    });
  }

  async info(id: number) {
    return await this.dictItemRepository.findOneBy({ id });
  }

  async update(id: number, dto: DictItemUpdateDto) {
    const { typeId, ...rest } = dto;
    const item = await this.dictItemRepository.findOne({
      where: {
        value: dto.value,
        type: {
          id: dto.typeId,
        },
      },
    });
    if (item && (await item.id) !== Number(id))
      throw new BusinessException(ErrorEnum.DICT_ITEM_EXIST);

    await this.dictItemRepository.update(id, {
      ...rest,
      type: await DictTypeEntity.findOneBy({
        id: dto.typeId,
      }),
    });
  }

  async batchUpdateStatus({ ids, status, updatedBy }: DictItemStatusDto) {
    await this.dictItemRepository.update(
      { id: In(ids) },
      { status, updatedBy },
    );
  }

  async delete(id: number) {
    await this.dictItemRepository.delete(id);
  }

  async batchDelete(ids: number[]) {
    await this.dictItemRepository.delete(ids);
  }
}
