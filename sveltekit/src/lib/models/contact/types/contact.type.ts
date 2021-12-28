export interface IContact {
	id?: string;
	phoneNumber?: string;
	info?: string;
	address?: string;
	email?: string;
}

export interface IContactReceved {
	contact: IContact;
}
