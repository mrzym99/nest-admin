import { Injectable } from '@nestjs/common';
import {
  registerDecorator,
  ValidationArguments,
  ValidationOptions,
  ValidatorConstraint,
  ValidatorConstraintInterface,
} from 'class-validator';
import { DataSource, Not, ObjectType } from 'typeorm';
import { ClsService } from 'nestjs-cls';
import { merge, isNil } from 'lodash';

interface Condition {
  entity: ObjectType<any>;
  /** 属性 */
  field?: string;
  /** 失败消息 */
  message?: string;
}

/**
 *  唯一性验证
 */
@ValidatorConstraint({ name: 'unique', async: false })
@Injectable()
export class UniqueConstraint implements ValidatorConstraintInterface {
  constructor(
    private dataSource: DataSource,
    private readonly cls: ClsService,
  ) {}

  async validate(value: any, args: ValidationArguments) {
    const config: Omit<Condition, 'entity'> = {
      field: args.property,
    };

    const condition = ('entity' in args.constraints[0]
      ? merge(config, args.constraints[0])
      : {
          ...config,
          entity: args.constraints[0],
        }) as unknown as Required<Condition>;

    if (!condition.entity) return false;

    try {
      // 查询是否存在数据 存在则验证失败
      const repo = this.dataSource.getRepository(condition.entity);
      // 如果没有传自定义的错误信息 则尝试使用该字段的 comment
      if (!condition.message) {
        const targetColumn = repo.metadata.findColumnWithPropertyName(
          condition.field,
        );
        if (targetColumn.comment) {
          args.constraints[0].message = `已存在相同的${targetColumn.comment}`;
        }
      }

      let andWhere = {};
      const operateId = this.cls.get('operateId');
      // 如果是编辑操作 则排除自身
      if (operateId) {
        andWhere = {
          id: Not(operateId),
        };
      }

      return isNil(
        await repo.findOne({
          where: {
            [condition.field]: value,
            ...andWhere,
          },
        }),
      );
    } catch (error) {
      console.log(error);

      return false;
    }
  }

  defaultMessage(args?: ValidationArguments): string {
    const { entity, field, message } = args.constraints[0] as Condition;
    const queryProperty = field ?? args.property;

    if (!entity) return 'Model not been specified!';

    return message || `${queryProperty} of ${entity.name} already exists!`;
  }
}

/**
 * 验证数据唯一性
 * @param entity  实体类
 * @param options
 */
function IsUnique(
  entity: ObjectType<any>,
  options?: ValidationOptions,
): (object: Record<string, any>, propertyName: string) => void;
function IsUnique(
  condition: Condition,
  options?: ValidationOptions,
): (object: Record<string, any>, propertyName: string) => void;
function IsUnique(
  params: ObjectType<any> | Condition,
  options?: ValidationOptions,
) {
  return function (object: Object, propertyName: string) {
    registerDecorator({
      target: object.constructor,
      propertyName,
      options,
      constraints: [params],
      validator: UniqueConstraint,
    });
  };
}

export { IsUnique };
