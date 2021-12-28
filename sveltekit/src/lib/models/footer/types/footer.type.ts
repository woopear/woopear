import type { IDateModel } from '$lib/models/date-model/types/date-model.type';

export interface IFooter extends IDateModel {
	id?: string;
	copyright?: string;
}

export interface IFooterReceved {
	footer: IFooter;
}
