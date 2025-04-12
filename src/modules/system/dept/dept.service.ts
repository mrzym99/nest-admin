import { Injectable } from '@nestjs/common';
import { DeptCreateDto, DeptQueryDto, DeptUpdateDto } from './dto/dept.dto';
import { DeptEntity } from './dept.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Like, Not, Repository, TreeRepository } from 'typeorm';

import { isEmpty } from 'lodash';
import { BusinessException } from '~/common/exceptions/biz.exception';
import { UserEntity } from '~/modules/user/user.entity';
import { ErrorEnum } from '~/constants/error.constant';
import { Pagination } from '~/helper/pagination/pagination';
import { createPaginationObject } from '~/helper/pagination/create-pagination';
import { deepSortTree } from '~/utils';

@Injectable()
export class DeptService {
  constructor(
    @InjectRepository(DeptEntity)
    private readonly deptRepository: TreeRepository<DeptEntity>,
    @InjectRepository(UserEntity)
    private readonly userRepository: Repository<UserEntity>,
  ) {}

  async list(dto: DeptQueryDto): Promise<Pagination<DeptEntity>> {
    const tree = await this.listDeptTree(dto);

    return createPaginationObject({
      list: tree,
      currentPage: 1,
      pageSize: tree.length,
      total: tree.length,
    });
  }

  async listDeptTree(dto: DeptQueryDto): Promise<DeptEntity[]> {
    const tree: DeptEntity[] = [];
    const { name } = dto;
    if (name) {
      const deptList = await this.deptRepository
        .createQueryBuilder('dept')
        .leftJoinAndSelect('dept.creator', 'creator')
        .leftJoinAndSelect('dept.updater', 'updater')
        .where('dept.name LIKE :name', { name: `%${name}%` })
        .getMany();

      for (const dept of deptList) {
        const deptTree = await this.deptRepository.findDescendantsTree(dept);
        tree.push(deptTree);
      }

      return deepSortTree(tree, 'order');
    }
    const deptTree = await this.deptRepository.findTrees({
      depth: 2,
      relations: ['parent', 'creator', 'updater'],
    });

    return deepSortTree(deptTree, 'order');
  }

  async create(DeptCreateDto: DeptCreateDto): Promise<void> {
    const { parentId, ...rest } = DeptCreateDto;
    const one = await this.deptRepository.findOneBy({
      name: rest.name,
    });
    if (one) throw new BusinessException(ErrorEnum.DEPT_EXIST);

    const parent = await this.deptRepository
      .createQueryBuilder('dept')
      .where('id = :id', { id: parentId })
      .getOne();

    const dept = await this.deptRepository.save({
      ...rest,
      parent,
    });

    if (dept.default) {
      this.setDefaultDept(dept.id);
    }
  }

  async update(id: number, deptUpdateDto: DeptUpdateDto): Promise<void> {
    const { parentId, ...rest } = deptUpdateDto;
    const item = await this.deptRepository
      .createQueryBuilder('dept')
      .where({ id })
      .getOne();

    const parent = await this.deptRepository
      .createQueryBuilder('dept')
      .where({ id: parentId })
      .getOne();

    await this.deptRepository.save({
      ...item,
      ...rest,
      parent,
    });
    if (rest.default) {
      this.setDefaultDept(id);
    }
  }

  async info(id: number): Promise<DeptEntity> {
    const dept = await this.deptRepository
      .createQueryBuilder('dept')
      .leftJoinAndSelect('dept.parent', 'parent')
      .where({ id })
      .getOne();

    if (isEmpty(dept)) {
      throw new BusinessException(ErrorEnum.DEPT_NOT_EXIST);
    }

    return dept;
  }

  async default(id: number) {
    await this.deptRepository.update({ id }, { default: 1 });
    await this.setDefaultDept(id);
  }

  async setDefaultDept(id: number) {
    await this.deptRepository.update(
      {
        id: Not(id),
      },
      { default: 0 },
    );
  }

  async delete(id: number): Promise<void> {
    await this.deptRepository.delete(id);
  }

  async countDeptUser(id: number): Promise<number> {
    const count = await this.userRepository.countBy({
      dept: { id },
    });

    return count;
  }

  async countChildDept(id: number): Promise<number> {
    const item = await this.deptRepository.findOneBy({ id });

    return (await this.deptRepository.countDescendants(item)) - 1;
  }

  async getDefaultDept(): Promise<DeptEntity> {
    const dept = await this.deptRepository.findOneBy({
      default: 1,
    });

    return dept;
  }
}
