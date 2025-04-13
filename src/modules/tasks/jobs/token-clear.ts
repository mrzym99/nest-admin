import { Injectable } from '@nestjs/common';
import { Mission } from '../mission.decorator';
import { CronService } from '~/shared/helper/cron.service';

@Injectable()
@Mission()
export class TokenClearJob {
  constructor(private readonly cronService: CronService) {}

  async clearExpiredAccessToken(): Promise<void> {
    await this.cronService.deleteExpiredAccessToken();
  }

  async clearExpiredRefreshToken(): Promise<void> {
    await this.cronService.deleteExpiredRefreshToken();
  }
}
