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

/**
 * interface de l'objet d'envoie du mail ce contact
 */
export interface IObjectSendMail {
	email?: string;
	tel?: string;
	message?: string;
}

/**
 * interface de la response denvoie du mail de contact
 */
export interface IObjectSedMailResponseReceved {
	state?: boolean;
	message?: string;
}
