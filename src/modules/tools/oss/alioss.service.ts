import * as OSS from 'ali-oss';
import { Inject, Injectable } from '@nestjs/common';
import { IOssConfig, OssConfig, ossRegToken } from '~/config';
import { genFileName, getExtname, getSize } from '~/utils';
import { createPaginationObject } from '~/helper/pagination/create-pagination';
import { isEmpty } from 'lodash';
import { Pagination } from '~/helper/pagination/pagination';
import { OssInfo } from './oss.model';
import { OssPageDto } from './oss.dto';

@Injectable()
export class AliOssService {
  private client: OSS;
  private ossConfig: IOssConfig;
  public constructor(@Inject(OssConfig.KEY) ossConfig: IOssConfig) {
    this.client = new OSS({
      accessKeyId: ossConfig.accessKey,
      accessKeySecret: ossConfig.secretKey,
      region: ossConfig.region,
      bucket: ossConfig.bucket,
    });
    this.ossConfig = ossConfig;
  }

  async list({
    currentPage,
    pageSize,
    name,
  }: OssPageDto): Promise<Pagination<OssInfo>> {
    const res = await this.client.listV2({}, {});

    let list = !isEmpty(res.objects)
      ? res.objects.map((item) => {
          return {
            id: item.etag,
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
      currentPage: 1,
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
  public async putOssFile(file: Express.Multer.File): Promise<string> {
    let res: any;
    try {
      if (!this.bucketExist()) {
        await this.client.putBucket(this.ossConfig.bucket);
      }
      const ossFileName = genFileName(file.originalname);
      res = await this.client.put(ossFileName, file.buffer);
      // 将文件设置为公共可读
      await this.client.putACL(ossFileName, 'public-read');
    } catch (error) {
      console.log(error);
    }
    return res.url;
  }
  /**
   * 获取文件的url
   * @param filePath
   */
  public async getFileSignatureUrl(filePath: string): Promise<string> {
    if (filePath == null) {
      console.log('get file signature failed: file name can not be empty');
      return null;
    }
    let result = '';
    try {
      result = this.client.signatureUrl(filePath, { expires: 36000 });
    } catch (err) {
      console.log(err);
    }
    return result;
  }
}
