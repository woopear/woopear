import type { IImage } from '$lib/models/image/types/image.type';
import type { IMethod } from '$lib/models/method/types/method.type';

export interface IStep {
	id?: string;
	title?: string;
	description?: string;
	position?: number;
	method?: IMethod;
	image?: IImage;
}

export interface IStepsReceved {
	steps: IStep[];
}

export interface IStepReceved {
	step: IStep;
}
