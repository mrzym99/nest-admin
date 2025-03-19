// import * as OSS from 'ali-oss';
// import { Inject, Injectable } from '@nestjs/common';
// import { IOssConfig, ossRegToken } from '~/config';

// @Injectable()
// export class OssService {
//   private client: OSS;
//   private ossConfig: IOssConfig;
//   public constructor(@Inject(ossRegToken) ossConfig: IOssConfig) {
//     this.client = new OSS({
//       accessKeyId: ossConfig.accessKey,
//       accessKeySecret: ossConfig.secretKey,
//       region: ossConfig.region,
//       bucket: ossConfig.bucket,
//     });
//     this.ossConfig = ossConfig;
//   }
//   // 创建存储空间。
//   private async putBucket() {
//     try {
//       const options = {
//         storageClass: 'Archive', // 存储空间的默认存储类型为标准存储，即Standard。如果需要设置存储空间的存储类型为归档存储，请替换为Archive。
//         acl: 'public-read', // 存储空间的默认读写权限为私有，即private。如果需要设置存储空间的读写权限为公共读，请替换为public-read。
//         dataRedundancyType: 'ZRS', // 存储空间的默认数据容灾类型为本地冗余存储，即LRS。如果需要设置数据容灾类型为同城冗余存储，请替换为ZRS。
//       };
//       const result = await this.client.putBucket('test');
//       console.log(result);
//     } catch (err) {
//       console.log(err);
//     }
//   }
//   // 列举所有的存储空间
//   private async listBuckets() {
//     try {
//       let result = await this.client.listBuckets({
//         'max-keys': 10,
//       });
//       console.log(result);
//     } catch (err) {
//       console.log(err);
//     }
//   }

//   async bucketExist() {
//     const bucketName = this.ossConfig.bucket;
//     if (bucketName) {
//       return await this.client.getBucketInfo(bucketName);
//     } else {
//       return false;
//     }
//   }

//   // 上传文件到oss 并返回  图片oss 地址
//   public async putOssFile(ossPath: string, localPath: string): Promise<string> {
//     let res: any;
//     try {
//       if (!this.bucketExist()) {
//         await this.client.putBucket(this.ossConfig.bucket);
//       }
//       res = await this.client.put(ossPath, localPath);
//       // 将文件设置为公共可读
//       await this.client.putACL(ossPath, 'public-read');
//     } catch (error) {
//       console.log(error);
//     }
//     return res.url;
//   }
//   /**
//    * 获取文件的url
//    * @param filePath
//    */
//   public async getFileSignatureUrl(filePath: string): Promise<string> {
//     if (filePath == null) {
//       console.log('get file signature failed: file name can not be empty');
//       return null;
//     }
//     let result = '';
//     try {
//       result = this.client.signatureUrl(filePath, { expires: 36000 });
//     } catch (err) {
//       console.log(err);
//     }
//     return result;
//   }
// }
