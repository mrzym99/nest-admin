import {
  BadRequestException,
  Controller,
  Inject,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { UploadService } from './upload.service';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { ApiBody, ApiConsumes, ApiOperation, ApiTags } from '@nestjs/swagger';
import { FileUploadDto } from './upload.dto';
import { FileInterceptor } from '@nestjs/platform-express';
import { Express } from 'express';
import { AuthUser } from '~/modules/auth/decorators/auth-user.decorator';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';
import { ErrorEnum } from '~/constants/error.constant';
import { env, uploadLocalStorage } from '~/utils';
import { AliOssService } from '../oss/alioss.service';
import { IOssConfig, OssConfig } from '~/config';

export const permissions = definePermission('upload', {
  UPLOAD: 'upload',
} as const);

function getStorage() {
  if (env('OSS_TYPE') === 'local' || env('OSS_TYPE') === '') {
    return uploadLocalStorage;
  }
  return null;
}

@ApiSecurityAuth()
@ApiTags('Tools - 上传模块')
@Controller('upload')
export class UploadController {
  constructor(
    private readonly uploadService: UploadService,
    private readonly aliOssService: AliOssService,
    @Inject(OssConfig.KEY)
    private readonly ossConfig: IOssConfig,
  ) {}

  // https://github.com/expressjs/multer#multeropts
  @UseInterceptors(FileInterceptor('file', { storage: getStorage() }))
  @Post()
  @Perm(permissions.UPLOAD)
  @ApiOperation({ summary: '上传文件' })
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    type: FileUploadDto,
  })
  async upload(@UploadedFile() file: Express.Multer.File, @AuthUser() user) {
    try {
      let path: string = '';
      switch (this.ossConfig.type) {
        case 'local':
          path = await this.uploadService.upload(file, user.uid);
          break;
        case 'aliyun':
          path = await this.aliOssService.putOssFile(file);
          break;
        default:
          break;
      }
      return path;
    } catch (error) {
      console.log(error);
      throw new BadRequestException(ErrorEnum.UPLOAD_FAIL);
    }
  }
}
