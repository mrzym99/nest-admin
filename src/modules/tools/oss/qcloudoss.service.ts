import * as OSS from 'cos-nodejs-sdk-v5';
import { Inject, Injectable, LoggerService } from '@nestjs/common';
import { IOssConfig, OssConfig } from '~/config';
import { OssPageDto } from './oss.dto';
import { Pagination } from '~/helper/pagination/pagination';
import { OssInfo } from './oss.model';
import { isEmpty } from 'lodash';
import { genFileName, getExtname, getSize } from '~/utils';
import { createPaginationObject } from '~/helper/pagination/create-pagination';
import { WINSTON_MODULE_NEST_PROVIDER } from 'nest-winston';
import { BusinessException } from '~/common/exceptions/biz.exception';
import { ErrorEnum } from '~/constants/error.constant';

@Injectable()
export class QClouldOssService {
  private client: OSS;
  private ossConfig: IOssConfig;
  public constructor(
    @Inject(OssConfig.KEY) ossConfig: IOssConfig,
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: LoggerService,
  ) {
    if (ossConfig.type !== 'qcloud') return;
    this.ossConfig = ossConfig;
    this.init();
  }

  async init() {
    if (
      !this.ossConfig.secretId ||
      !this.ossConfig.secretKey ||
      !this.ossConfig.bucket
    ) {
      this.logger.error('[QCLOULD_OSS]', '请检查OSS配置');
      return;
    }
    this.client = new OSS({
      SecretId: this.ossConfig.secretId,
      SecretKey: this.ossConfig.secretKey,
      Domain: this.ossConfig.domain,
    });
  }

  // 创建存储空间。
  private async putBucket() {
    try {
      const result = await this.client.putBucket({
        Bucket: this.ossConfig.bucket,
        Region: this.ossConfig.region,
      });
      console.log(result);
    } catch (err) {
      console.log(err);
    }
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
    return new Promise((resolve, reject) => {
      this.client.getBucket(
        {
          Bucket: this.ossConfig.bucket,
          Region: this.ossConfig.region,
        },
        function (err, data) {
          if (err) {
            reject(err);
          } else {
            let list = !isEmpty(data.Contents)
              ? data.Contents.map((item, index) => {
                  return {
                    id: index + 1,
                    name: item.Key,
                    size: getSize(Number(item.Size)),
                    lastModified: item.LastModified,
                    type: item.StorageClass,
                    url: '', // url 需要使用 getObjectUrl 方法获取
                    extName: getExtname(item.Key),
                  };
                }).filter((item) => item.extName)
              : [];

            if (name) {
              list = list.filter((item) => item.name.includes(name));
            }

            list = list.slice(
              (currentPage - 1) * pageSize,
              pageSize * currentPage,
            );

            resolve(
              createPaginationObject({
                currentPage: currentPage,
                pageSize: pageSize,
                total: list.length,
                list,
              }),
            );
          }
        },
      );
    });
  }

  async bucketExist() {
    return new Promise((resolve, reject) => {
      this.client.headBucket(
        {
          Bucket: this.ossConfig.bucket, // 填入您自己的存储桶，必须字段
          Region: this.ossConfig.region, // 存储桶所在地域，例如 ap-beijing，必须字段
        },
        function (err, data) {
          if (data) {
            resolve(true);
          } else {
            reject(false);
          }
        },
      );
    });
  }

  // 上传文件到oss 并返回  图片oss 地址
  public async putOssFile(file: Express.Multer.File): Promise<string> {
    if (!this.client) {
      throw new BusinessException(ErrorEnum.UPLOAD_NOT_INIT);
    }
    return new Promise(async (resolve, reject) => {
      try {
        const exist = await this.bucketExist();
        if (!exist) {
          await this.putBucket();
        }
        const ossPath = genFileName(file.originalname);
        const buffer = Buffer.from(file.buffer);
        this.client.putObject(
          {
            Bucket: this.ossConfig.bucket,
            Region: this.ossConfig.region,
            Key: ossPath,
            Body: buffer,
            StorageClass: 'STANDARD',
            ACL: 'public-read',
          },
          (err, data) => {
            if (err) {
              console.log(err);
              reject(err);
            } else {
              this.client.getObjectUrl(
                {
                  Bucket: this.ossConfig.bucket,
                  Region: this.ossConfig.region,
                  Key: ossPath,
                  Sign: false,
                },
                (err, data) => {
                  if (err) {
                    console.log(err);
                    reject(err);
                  }
                  resolve(data.Url);
                },
              );
            }
          },
        );
      } catch (error) {
        console.log(error);
      }
    });
  }

  async deleteFiles(fileKeys: string[]) {
    if (!this.client) {
      throw new BusinessException(ErrorEnum.UPLOAD_NOT_INIT);
    }
    const objectList = fileKeys.map((fileKey) => {
      return {
        Key: fileKey,
      };
    });
    await this.client.deleteMultipleObject({
      Bucket: this.ossConfig.bucket,
      Region: this.ossConfig.region,
      Objects: objectList,
    });
  }
}
