export interface IArticle {
  id?: string,
  title?: string,
  image?: string,
  content?: IArticleContent
}

export interface IArticleContent {
  id?: string,
  sub_title: string,
  text?: string
}

export interface IAdverting {
  id?: string,
  title?: string,
  imaage?: string,
  label?: IAdvertingLabel
}

export interface IAdvertingLabel {
  libelle?: string,
  description?:string
}