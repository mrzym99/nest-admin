import { Injectable } from '@nestjs/common';
import { LoginLogCreateDto, LoginLogQueryDto } from '../dto/log.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { LoginLogEntity } from '../entities/login-log.entity';
import { Between, LessThan, Like, Repository } from 'typeorm';
import { getIpAddress } from '~/utils/ip.util';
import { paginate } from '~/helper/pagination';
import { UAParser } from 'ua-parser-js';

async function parseLoginLog(e: any, parser: UAParser): Promise<any> {
  const uaResult = parser.setUA(e.userAgent).getResult();

  return {
    id: e.id,
    ip: e.ip,
    address: e.address,
    os: `${`${uaResult.os.name ?? ''} `}${uaResult.os.version}`,
    browser: `${`${uaResult.browser.name ?? ''} `}${uaResult.browser.version}`,
    username: e.user.username,
    nickName: e.user.profile.nickName,
    time: e.createdAt,
  };
}

@Injectable()
export class LoginLogService {
  constructor(
    @InjectRepository(LoginLogEntity)
    private readonly loginLogRepository: Repository<LoginLogEntity>,
  ) {}

  async list({
    currentPage,
    pageSize,
    username,
    ip,
    address,
    time,
  }: LoginLogQueryDto) {
    const queryBuilder = this.loginLogRepository
      .createQueryBuilder('login_log')
      .innerJoinAndSelect('login_log.user', 'user')
      .leftJoinAndSelect('user.profile', 'profile')
      .where({
        ...(ip && { ip: Like(`%${ip}%`) }),
        ...(address && { address: Like(`%${address}%`) }),
        ...(time &&
          time.length > 1 && {
            createdAt: Between(
              new Date(parseInt(time[0])),
              new Date(parseInt(time[1])),
            ),
          }),

        ...(username && {
          user: {
            username: Like(`%${username}%`),
          },
        }),
      })
      .orderBy('login_log.createdAt', 'DESC');

    const parser = new UAParser();
    const { list, total } = await paginate<LoginLogEntity>(queryBuilder, {
      currentPage,
      pageSize,
    });

    const listData = await Promise.all(
      list.map((l) => parseLoginLog(l, parser)),
    );

    return {
      currentPage,
      pageSize,
      list: listData,
      total,
    };
  }

  async create({ ip, userAgent, userId }: LoginLogCreateDto) {
    try {
      const address = await getIpAddress(ip);
      await this.loginLogRepository.save({
        ip,
        address,
        userAgent,
        user: {
          id: userId,
        },
      });
    } catch (error) {
      console.log(error);
    }
  }

  async deleteLogs(ids: number[]): Promise<void> {
    await this.loginLogRepository.delete(ids);
  }

  async clearLog(): Promise<void> {
    await this.loginLogRepository.clear();
  }

  async clearLogBeforeTime(time: Date): Promise<void> {
    await this.loginLogRepository.delete({
      createdAt: LessThan(time),
    });
  }
}
