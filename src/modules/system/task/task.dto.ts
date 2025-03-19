import { BadRequestException } from '@nestjs/common';
import {
  IsDate,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  MaxLength,
  Min,
  MinLength,
  Validate,
  ValidateIf,
  ValidationArguments,
  ValidatorConstraint,
  ValidatorConstraintInterface,
} from 'class-validator';
import { isEmpty } from 'lodash';
import { CronExpressionParser } from 'cron-parser';
import { ApiProperty, ApiPropertyOptional, PartialType } from '@nestjs/swagger';
import { TaskEntity } from './task.entity';
import { IsUnique } from '~/shared/database/constraints/unique.constraint';
import { PagerDto } from '~/common/dto/pager.dto';
import { ToDate, ToNumber } from '~/common/decorators/transform.decorator';

/**
 * 校验 cron 表达式
 */
@ValidatorConstraint({ name: 'isCronExpression', async: false })
export class IsCornExpression implements ValidatorConstraintInterface {
  validate(value: any, _args?: ValidationArguments) {
    try {
      if (isEmpty(value)) throw new BadRequestException('corn表达式不能为空');
      CronExpressionParser.parse(value);
      return true;
    } catch (error) {
      return false;
    }
  }

  defaultMessage(_args?: ValidationArguments): string {
    return 'cron表达式格式不正确';
  }
}

export class TaskCreateDto {
  @ApiProperty({ description: '任务名称' })
  @IsUnique({ entity: TaskEntity, message: '任务名称已存在' })
  @IsString()
  @MinLength(2)
  @MaxLength(50)
  name: string;

  @ApiProperty({ description: '调用的服务' })
  @IsString()
  @MinLength(1)
  service: string;

  @ApiProperty({ description: '任务类别：cron | interval' })
  @IsIn([0, 1])
  type: number;

  @ApiProperty({ description: '任务状态' })
  @IsIn([0, 1])
  status: number;

  @ApiPropertyOptional({ description: '开始时间', type: Date })
  @IsOptional()
  @ToDate()
  startTime: Date;

  @ApiPropertyOptional({ description: '结束时间', type: Date })
  @IsOptional()
  @ToDate()
  endTime: Date;

  @ApiPropertyOptional({
    description: '限制执行次数，负数则无限制',
  })
  @IsOptional()
  @IsInt()
  limit?: number = -1;

  @ApiProperty({ description: 'cron表达式' })
  @Validate(IsCornExpression)
  @ValidateIf((o) => o.type === 0)
  cron: string;

  @ApiProperty({ description: '执行间隔，毫秒单位' })
  @IsInt()
  @Min(100)
  @ValidateIf((o) => o.type === 1)
  every?: number;

  @ApiPropertyOptional({ description: '执行参数' })
  @IsOptional()
  @IsString()
  data?: string;

  @ApiPropertyOptional({ description: '任务备注' })
  @IsOptional()
  @IsString()
  remark?: string;
}

export class TaskUpdateDto extends PartialType(TaskCreateDto) {}

export class TaskQueryDto extends PagerDto {
  @ApiProperty({
    description: '任务名称',
  })
  @IsOptional()
  @IsString()
  name?: string;

  @ApiProperty({
    description: '服务名称',
  })
  @IsOptional()
  @IsString()
  service?: string;

  @ApiProperty({
    description: '服务名称',
  })
  @IsOptional()
  @IsInt()
  @ToNumber()
  @IsIn([0, 1])
  type?: number;

  @ApiProperty({
    description: '状态',
  })
  @IsOptional()
  @IsInt()
  @ToNumber()
  @IsIn([0, 1])
  status?: number;
}
