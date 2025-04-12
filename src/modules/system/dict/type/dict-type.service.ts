import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DictTypeEntity } from './dict-type.entity';
import { In, Like, Repository } from 'typeorm';
import {
  DictTypeCreateDto,
  DictTypeQueryDto,
  DictTypeStatusDto,
  DictTypeUpdateDto,
} from './dict-type.dto';
import { paginate } from '~/helper/pagination';
import { ErrorEnum } from '~/constants/error.constant';
import { DictItemService } from '../item/dict-item.service';
import { Status } from '~/constants/common.constant';

@Injectable()
export class DictTypeService {
  constructor(
    @InjectRepository(DictTypeEntity)
    private readonly dictTypeRepository: Repository<DictTypeEntity>,
    private readonly dictItemService: DictItemService,
  ) {}

  async list({ currentPage, pageSize, name, code }: DictTypeQueryDto) {
    const queryBuilder = await this.dictTypeRepository
      .createQueryBuilder('dict_type')
      .where({
        ...(name && { name: Like(`%${name}%`) }),
        ...(code && { code: Like(`%${code}%`) }),
      });

    return await paginate<DictTypeEntity>(queryBuilder, {
      currentPage,
      pageSize,
    });
  }

  async dictItemList(code: string) {
    const dictType = await this.dictTypeRepository.findOneBy({ code });
    if (!dictType) throw new NotFoundException(ErrorEnum.DICT_TYPE_NOT_FOUND);

    if (dictType.status === Status.Disabled) return [];
    return await this.dictItemService.getDictItemListByTypeId(dictType.id);
  }

  async create(dto: DictTypeCreateDto) {
    await this.dictTypeRepository.save(dto);
  }

  async info(id: number) {
    return await this.dictTypeRepository.findOneBy({ id });
  }

  async update(id: number, dto: DictTypeUpdateDto) {
    await this.dictTypeRepository.update(id, dto);
  }

  async batchUpdateStatus({ ids, status, updatedBy }: DictTypeStatusDto) {
    await this.dictTypeRepository.update(
      { id: In(ids) },
      { status, updatedBy },
    );
  }

  async delete(id: number) {
    await this.dictItemService.validateDelete(id);
    await this.dictTypeRepository.delete(id);
  }
}
