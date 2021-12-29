import type { IDateModel } from '$lib/models/date-model/types/date-model.type';

/**
 * interface pour le footer
 */
export interface IFooter extends IDateModel {
	id?: string;
	copyright?: string;
}

/**
 * interface pour l'bjet reçus par graphql
 */
export interface IFooterReceved {
	footer?: IFooter;
}
