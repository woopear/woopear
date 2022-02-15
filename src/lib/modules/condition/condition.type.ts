/* 
* interface content de condition
*/

export interface IConditionContent {
  id?: string,
  text?: string
}

/* 
* interface condition
*/
export interface ICondition {
  id?: string,
  type?: string,
  title?: string,
  sub_title?: string,
  content?: IConditionContent[]
}

/* 
* interface  de condition géneral
*/
export interface IConditionGeneral {
  id?: string,
  title?: string,
  conditions?: ICondition[]
}