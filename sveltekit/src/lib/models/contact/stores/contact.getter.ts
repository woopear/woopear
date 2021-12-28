import type { IContact } from '../types/contact.type';
import { contactStore } from './contact.store';

export const contactGetter = {
	/**
	 * sub contact
	 */
	getterContact: (): IContact => {
		let c: IContact;
		contactStore.subscribe((v) => (c = v.contact));
		return c;
	}
};
