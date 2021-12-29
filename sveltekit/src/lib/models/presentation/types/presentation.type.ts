import type { IDateModel } from '$lib/models/date-model/types/date-model.type';
import type { IImage } from '$lib/models/image/types/image.type';

/**
 * interface presentation
 */
export interface IPresentation extends IDateModel {
	id?: string;
	title?: string;
	subTitle?: string;
	description?: string;
	image?: IImage;
}

/**
 * interface pour l'bjet reçus par graphql
 */
export interface IPresentationReceved {
	presentation?: IPresentation;
}
