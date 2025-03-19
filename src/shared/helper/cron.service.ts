import { Injectable, Logger } from '@nestjs/common';
import * as dayjs from 'dayjs';
import { LessThan } from 'typeorm';
import { AccessTokenEntity } from '~/modules/auth/entities/access-token.entity';

@Injectable()
export class CronService {
  private logger = new Logger(CronService.name);

  constructor() {}

  async deleteExpiredToken() {
    // 删除过期的token
    this.logger.log('---> 开始扫描 sys_access_token 删除过期的token');

    const expiredToken = await AccessTokenEntity.find({
      where: {
        expiredAt: LessThan(new Date()),
      },
    });
    let deleCount = 0;
    await Promise.all(
      expiredToken.map(async (token) => {
        const { value, createdAt } = token;
        await AccessTokenEntity.remove(token);
        this.logger.debug(
          `---> 删除过期的token ${value}，签发于 ${dayjs(createdAt).format('YYYY-MM-DD HH:mm:ss')}`,
        );

        deleCount++;
      }),
    );

    this.logger.log(`---> 删除过期的token，共删除 ${deleCount} 个`);
  }
}
