import type { IDateModel } from '$lib/models/date-model/types/date-model.type';

/**
 * interface de la partie contact du site
 */
export interface IContact extends IDateModel {
	id?: string;
	phoneNumber?: string;
	info?: string;
	address?: string;
	email?: string;
}

/**
 * interface de l'objet reçus par le back
 */
export interface IContactReceved {
	contact: IContact;
}
