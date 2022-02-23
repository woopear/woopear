import type { IWoopear } from '../woopear/woopear.type';

/**
 * interface pour les contents de la présentation
 */
export interface IPresentationContent {
  id?: string;
  sub_title?: string;
  text?: string;
}

/**
 * interface pour la présentation
 */
export interface IPresentation {
  id?: string;
  title?: string;
  sub_title?: string;
  contents?: IPresentationContent[];
  image?: string;
  woopear?: IWoopear;
  active?: boolean;
}
