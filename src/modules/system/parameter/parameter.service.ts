import { Injectable } from '@nestjs/common';
import {
  ParameterCreateDto,
  ParameterQueryDto,
  ParameterUpdateDto,
} from './dto/parameter.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { ParameterEntity } from './parameter.entity';
import { Like, Repository } from 'typeorm';
import { paginate } from '~/helper/pagination';

@Injectable()
export class ParameterService {
  constructor(
    @InjectRepository(ParameterEntity)
    private readonly parameterRepository: Repository<ParameterEntity>,
  ) {}
  async create(dto: ParameterCreateDto) {
    await this.parameterRepository.save(dto);
  }

  async list({ currentPage, pageSize, name }: ParameterQueryDto) {
    const queryBuilder = await this.parameterRepository
      .createQueryBuilder('parameter')
      .where({
        ...(name ? { name: Like(`%${name}%`) } : null),
      });

    return paginate<ParameterEntity>(queryBuilder, { currentPage, pageSize });
  }

  async findOne(id: number) {
    return await this.parameterRepository.findOne({ where: { id } });
  }

  async findOneByKey(key: string) {
    const one = await this.parameterRepository.findOneBy({ key });
    if (!one) return null;
    return one.value;
  }

  async update(id: number, dto: ParameterUpdateDto) {
    await this.parameterRepository.update(id, dto);
  }

  async delete(id: number) {
    await this.parameterRepository.delete(id);
  }
}
