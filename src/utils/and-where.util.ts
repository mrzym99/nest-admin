import { SelectQueryBuilder } from 'typeorm';
import { isNil } from 'lodash';

type Conditions = {
  [key: string]: Condition;
};

type Condition = {
  field: string;
  operator: string;
  value: any;
};

export function andWhereConditions(
  queryBuilder: SelectQueryBuilder<any>,
  conditions: Conditions,
) {
  for (const key in conditions) {
    const condition = conditions[key];
    // queryBuilder.andWhere('profile.email like :email', {
    //   email: `%${email}%`,
    // });

    if (!isNil(condition.value)) {
      if (condition.operator === 'LIKE') {
        queryBuilder.andWhere(
          `${condition.field} ${condition.operator} :${key}`,
          { [key]: `%${condition.value}%` },
        );
      } else if (condition.operator === 'IN') {
        queryBuilder.andWhere(
          `${condition.field} ${condition.operator} (:...${key})`,
          { [key]: condition.value },
        );
      } else {
        queryBuilder.andWhere(
          `${condition.field} ${condition.operator} :${key}`,
          { [key]: condition.value },
        );
      }
    }
  }
}
