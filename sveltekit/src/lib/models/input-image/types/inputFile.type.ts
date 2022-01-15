import type { IImage } from './../../image/types/image.type';
import type { IDateModel } from '$lib/models/date-model/types/date-model.type';



/** 
 * interface pour l'bjet reçus par graphql
*/
export interface IInputImageReceved {
  inputImage?: IImage;
}


export interface IInputImageCreateReceved {
  upload?: IImage;
}

export interface IInputImageDeleteReceved {
  file?: IImage;
}