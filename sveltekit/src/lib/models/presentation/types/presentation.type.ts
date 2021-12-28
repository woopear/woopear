import type { IDateModel } from '$lib/models/date-model/types/date-model.type';
import type { IImage } from '$lib/models/image/types/image.type';

export interface IPresentation extends IDateModel {
	id?: string;
	title?: string;
	subTitle?: string;
	description?: string;
	image?: IImage;
}

export interface IPresentationReceved {
	presentation?: IPresentation;
}
