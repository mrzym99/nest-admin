import { Injectable } from '@nestjs/common';
import {
  NoticeCreateDto,
  NoticeQueryDto,
  NoticeStatusDto,
  NoticeUpdateDto,
} from './dto/notice.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { NoticeEntity } from './notice.entity';
import { In, Like, Repository } from 'typeorm';
import { paginate } from '~/helper/pagination';

@Injectable()
export class NoticeService {
  constructor(
    @InjectRepository(NoticeEntity)
    private readonly noticeRepository: Repository<NoticeEntity>,
  ) {}
  async create(dto: NoticeCreateDto) {
    await this.noticeRepository.save(dto);
  }

  async list({ currentPage, pageSize, name }: NoticeQueryDto) {
    const queryBuilder = await this.noticeRepository
      .createQueryBuilder('notice')
      .where({
        ...(name ? { name: Like(`%${name}%`) } : null),
      });

    return paginate<NoticeEntity>(queryBuilder, { currentPage, pageSize });
  }

  async findOne(id: number) {
    return await this.noticeRepository.findBy({ id });
  }

  async update(id: number, dto: NoticeUpdateDto) {
    await this.noticeRepository.update(id, dto);
  }

  async delete(id: number) {
    await this.noticeRepository.delete(id);
  }

  async batchUpdateStatus({ ids, status, updatedBy }: NoticeStatusDto) {
    await this.noticeRepository.update({ id: In(ids) }, { status, updatedBy });
  }
}
