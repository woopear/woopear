import type { IContact } from '../types/contact.type';
import { contactStore } from './contact.store';

export const contactMutation = {
	/**
	 * set contact
	 */
	setContact: (contact: IContact): void => {
		contactStore.update((n) => {
			n.contact = contact;
			return n;
		});
	}
};
