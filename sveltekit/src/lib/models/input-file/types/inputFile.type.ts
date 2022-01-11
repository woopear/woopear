import type { IDateModel } from '$lib/models/date-model/types/date-model.type';


/** 
 * interface inputFile
*/

export interface IInputFile extends IDateModel {
  id?:string;
  name?: string;
  alternativeText?: string;
  caption?: string;
  width?: number;
  height?: number;
  formats?: JSON;
  hash?: string;
  ext?: string;
  mime?: string;
  size?: number;
  url?: string;
  previewUrl?: string;
  provider?: string;
  provider_metadata?: string;
  related?: string;
  created_by?: string;
  updated_by?: string;
}

/** 
 * interface pour l'bjet reçus par graphql
*/
export interface IInputFileReceved {
  inputFile?: IInputFile;
}

/**
 * interface pour l'objet update reçu par graphql
 */
export interface IInputFileUpdateReceved {
  updateInputFile: IInputFileReceved;
}