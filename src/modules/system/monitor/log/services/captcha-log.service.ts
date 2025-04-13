import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { CaptchaLogEntity } from '../entities/captcha-log.entity';
import { LessThan, Repository } from 'typeorm';
import { CaptchaLogQueryDto } from '../dto/log.dto';
import { paginate } from '~/helper/pagination';

@Injectable()
export class CaptchaLogService {
  constructor(
    @InjectRepository(CaptchaLogEntity)
    private readonly captchaLogRepository: Repository<CaptchaLogEntity>,
  ) {}

  async create(
    account: string,
    code: string,
    provider: 'sms' | 'email' | 'captcha',
  ): Promise<number> {
    const captchaLog = await this.captchaLogRepository.save({
      account,
      code,
      provider,
    });

    return captchaLog.id;
  }

  async list({ currentPage, pageSize, account, provider }: CaptchaLogQueryDto) {
    const queryBuilder = await this.captchaLogRepository
      .createQueryBuilder('captcha_log')
      .where({
        ...(account ? { account } : null),
        ...(provider ? { provider } : null),
      })
      .orderBy({ 'captcha_log.createdAt': 'DESC' });

    return paginate<CaptchaLogEntity>(queryBuilder, { currentPage, pageSize });
  }

  async deleteLogs(ids: number[]): Promise<void> {
    await this.captchaLogRepository.delete(ids);
  }

  async clearLog(): Promise<void> {
    await this.captchaLogRepository.clear();
  }

  async clearLogBeforeTime(time: Date): Promise<void> {
    await this.captchaLogRepository.delete({ createdAt: LessThan(time) });
  }
}
