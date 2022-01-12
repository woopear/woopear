import type { IImage } from './../../image/types/image.type';
import type { IDateModel } from '$lib/models/date-model/types/date-model.type';



/** 
 * interface pour l'bjet reçus par graphql
*/
export interface IInputImageReceved {
  inputImage?: IImage;
}

/**
 * interface pour l'objet update reçu par graphql
 */
export interface IInputImageUpdateReceved {
  updateInputImage: IInputImageReceved;
}

export interface IInputImageCreateReceved {
  createImage: IInputImageReceved;
}