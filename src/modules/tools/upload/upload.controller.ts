import {
  BadRequestException,
  Body,
  Controller,
  Delete,
  Inject,
  Post,
  Req,
} from '@nestjs/common';
import { UploadService } from './upload.service';
import { ApiSecurityAuth } from '~/common/decorators/swagger.decorators';
import { ApiBody, ApiConsumes, ApiOperation, ApiTags } from '@nestjs/swagger';
import { FileUploadDto } from './upload.dto';
import { AuthUser } from '~/modules/auth/decorators/auth-user.decorator';
import {
  definePermission,
  Perm,
} from '~/modules/auth/decorators/permission.decorator';
import { ErrorEnum } from '~/constants/error.constant';
import { env } from '~/utils';
import { AliOssService } from '../oss/alioss.service';
import { IOssConfig, OssConfig } from '~/config';
import { QClouldOssService } from '../oss/qcloudoss.service';
import { DeleteFileDto } from '~/common/dto/delete.dto';
import { StorageService } from '../storage/storage.service';
import { FastifyRequest } from 'fastify';

export const permissions = definePermission('upload', {
  UPLOAD: 'upload',
} as const);

@ApiSecurityAuth()
@ApiTags('Tools - 上传模块')
@Controller('upload')
export class UploadController {
  constructor(
    private readonly storageService: StorageService,
    private readonly uploadService: UploadService,
    private readonly aliOssService: AliOssService,
    private readonly qcloudOssService: QClouldOssService,
    @Inject(OssConfig.KEY)
    private readonly ossConfig: IOssConfig,
  ) {}

  @Post()
  @Perm(permissions.UPLOAD)
  @ApiOperation({ summary: '上传文件' })
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    type: FileUploadDto,
  })
  async upload(@Req() req: FastifyRequest, @AuthUser() user) {
    const file = await req.file();

    try {
      let path: string = '';
      switch (this.ossConfig.type) {
        case 'local':
          path = await this.uploadService.upload(file, user.uid);
          break;
        case 'aliyun':
          path = await this.aliOssService.putOssFile(file);
          break;
        case 'qcloud':
          path = await this.qcloudOssService.putOssFile(file);
          break;
        default:
          break;
      }
      if (!path) {
        throw new BadRequestException(ErrorEnum.UPLOAD_FAIL);
      }
      return path;
    } catch (error) {
      console.log(error);
      throw new BadRequestException(ErrorEnum.UPLOAD_FAIL);
    }
  }

  @Delete('delete')
  @ApiOperation({ summary: '删除文件' })
  async delete(@Body() dto: DeleteFileDto) {
    const { fileNames } = dto;

    switch (this.ossConfig.type) {
      case 'local':
        await this.storageService.deleteFilesByFileName(fileNames);
        break;
      case 'aliyun':
        await this.aliOssService.deleteFiles(fileNames);
        break;
      case 'qcloud':
        await this.qcloudOssService.deleteFiles(fileNames);
        break;
      default:
        break;
    }
  }
}
