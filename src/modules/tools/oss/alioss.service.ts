import * as OSS from 'ali-oss';
import { Inject, Injectable, LoggerService } from '@nestjs/common';
import { IOssConfig, OssConfig } from '~/config';
import { genFileName, getExtname, getSize } from '~/utils';
import { createPaginationObject } from '~/helper/pagination/create-pagination';
import { isEmpty } from 'lodash';
import { Pagination } from '~/helper/pagination/pagination';
import { OssInfo } from './oss.model';
import { OssPageDto } from './oss.dto';
import { MultipartFile } from '@fastify/multipart';
import { BusinessException } from '~/common/exceptions/biz.exception';
import { ErrorEnum } from '~/constants/error.constant';
import { WINSTON_MODULE_NEST_PROVIDER } from 'nest-winston';

@Injectable()
export class AliOssService {
  private client: OSS;
  private ossConfig: IOssConfig;
  public constructor(
    @Inject(OssConfig.KEY) ossConfig: IOssConfig,
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: LoggerService,
  ) {
    if (ossConfig.type !== 'aliyun') return;
    this.ossConfig = ossConfig;
    this.init();
  }

  async init() {
    if (
      !this.ossConfig.secretId ||
      !this.ossConfig.secretKey ||
      !this.ossConfig.bucket
    ) {
      this.logger.error('[ALI_OSS]', '请检查OSS配置');
      return;
    }
    this.client = new OSS({
      accessKeyId: this.ossConfig.secretId,
      accessKeySecret: this.ossConfig.secretKey,
      region: this.ossConfig.region,
      bucket: this.ossConfig.bucket,
      endpoint: this.ossConfig.domain,
    });
  }

  async list({
    currentPage,
    pageSize,
    name,
  }: OssPageDto): Promise<Pagination<OssInfo>> {
    if (!this.client) {
      return {
        currentPage: 1,
        pageSize: 10,
        total: 0,
        list: [],
      };
    }
    const res = await this.client.listV2({}, {});

    let list = !isEmpty(res.objects)
      ? res.objects.map((item, index) => {
          return {
            id: index + 1,
            name: item.name,
            size: getSize(item.size),
            lastModified: item.lastModified,
            type: item.type,
            url: item.url,
            extName: getExtname(item.name),
          };
        })
      : [];

    if (name) {
      list = list.filter((item) => item.name.includes(name));
    }

    list = list.slice((currentPage - 1) * pageSize, pageSize * currentPage);

    return createPaginationObject({
      currentPage: currentPage,
      pageSize: pageSize,
      total: list.length,
      list,
    });
  }

  async bucketExist() {
    const bucketName = this.ossConfig.bucket;
    if (bucketName) {
      return await this.client.getBucketInfo(bucketName);
    } else {
      return false;
    }
  }

  // 上传文件到oss 并返回  图片oss 地址
  public async putOssFile(file: MultipartFile): Promise<string> {
    let res: any;
    try {
      if (!this.bucketExist()) {
        await this.client.putBucket(this.ossConfig.bucket);
      }
      const ossFileName = genFileName(file.filename);
      res = await this.client.put(ossFileName, file.toBuffer());
      // 将文件设置为公共可读
      await this.client.putACL(ossFileName, 'public-read');
    } catch (error) {
      console.log(error);
    }
    return res.url;
  }

  async deleteFiles(fileNames: string[]) {
    if (!this.client) {
      throw new BusinessException(ErrorEnum.UPLOAD_NOT_INIT);
    }
    await this.client.deleteMulti(fileNames, {
      quiet: true,
    });
  }
}
