import type { IImage } from '$lib/models/image/types/image.type';

export interface IPresentation {
	id?: string;
	title?: string;
	subTitle?: string;
	description?: string;
	image?: IImage;
}

export interface IPresentationReceved {
	presentation: IPresentation;
}
