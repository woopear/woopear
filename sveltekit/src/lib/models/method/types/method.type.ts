import type { IStep } from '$lib/models/step/types/step.type';

/**
 * interface pour la method
 */
export interface IMethod {
	id?: string;
	title?: string;
	description?: string;
	steps?: IStep[];
}

/**
 * interface pour l'bjet reçus par graphql
 */
export interface IMethodReceved {
	method: IMethod;
}
