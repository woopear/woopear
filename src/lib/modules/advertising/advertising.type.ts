/* 
* interface content de l'article de la pub
*/
export interface IAdvertingArticleContent {
  id?: string,
  sub_title?: string,
  text?: string
}

/* 
* interface article de la pub
*/
export interface IAdvertingArticle {
  id?: string,
  title?: string,
  image?: string,
  content?: IAdvertingArticleContent[],
  active?: boolean,
}

/* 
* interface label  de la pub
*/
export interface IAdvertingLabel {
  libelle?: string,
  description?:string
}

/* 
* interface de la pub
*/
export interface IAdverting {
  id?: string,
  title?: string,
  image?: string,
  label?: IAdvertingLabel,
  article?: IAdvertingArticle[],
  active?: boolean,
}
