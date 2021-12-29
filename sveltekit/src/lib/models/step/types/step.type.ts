import type { IImage } from '$lib/models/image/types/image.type';
import type { IMethod } from '$lib/models/method/types/method.type';

/**
 * interface step
 */
export interface IStep {
	id?: string;
	title?: string;
	description?: string;
	position?: number;
	method?: IMethod;
	image?: IImage;
}

/**
 * interface pour l'bjet reçus par graphql pour tout les steps
 */
export interface IStepsReceved {
	steps: IStep[];
}

/**
 * interface pour l'bjet reçus par graphql pour un step
 */
export interface IStepReceved {
	step: IStep;
}
