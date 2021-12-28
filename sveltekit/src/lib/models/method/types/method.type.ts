import type { IStep } from '$lib/models/step/types/step.type';

export interface IMethod {
	id?: string;
	title?: string;
	description?: string;
	steps?: IStep[];
}

export interface IMethodReceved {
	method: IMethod;
}
