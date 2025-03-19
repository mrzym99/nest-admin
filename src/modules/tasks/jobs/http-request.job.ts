import { HttpService } from '@nestjs/axios';
import {
  BadRequestException,
  Inject,
  Injectable,
  LoggerService,
} from '@nestjs/common';
import { Mission } from '../mission.decorator';
import { WINSTON_MODULE_NEST_PROVIDER } from 'nest-winston';

@Injectable()
@Mission()
export class HttpRequestJob {
  constructor(
    private readonly httpService: HttpService,
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: LoggerService,
  ) {}

  async handle(config: any) {
    if (config) {
      const result = await this.httpService.request(config);
      this.logger.log(result, 'HttpRequestJob: ' + HttpRequestJob.name);
    } else {
      throw new BadRequestException('HttpRequestJob：HttpRequest 参数为空');
    }
  }
}
