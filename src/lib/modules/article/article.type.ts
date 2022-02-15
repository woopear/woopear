/* 
* interface content de l'article
*/
export interface IArticleContent {
  id?: string,
  sub_title: string,
  text?: string
}

/* 
* interface article
*/
export interface IArticle {
  id?: string,
  title?: string,
  image?: string,
  content?: IArticleContent[]
}

/* 
* interface label de l'adverting
*/
export interface IAdvertingLabel {
  libelle?: string,
  description?:string
}

/* 
* interface de l'adverting
*/
export interface IAdverting {
  id?: string,
  title?: string,
  imaage?: string,
  label?: IAdvertingLabel
}
