/*
 * interface content de condition
 */

export interface IConditionContent {
  id?: string;
  content?: string;
}

/*
 * interface condition
 */
export interface ICondition {
  id?: string;
  type?: string;
  title?: string;
  sub_title?: string;
  contents?: IConditionContent[];
}

/*
 * interface  de condition géneral
 */
export interface IConditionGeneral {
  id?: string;
  title?: string;
  active?: boolean;
  conditions?: ICondition[];
}
