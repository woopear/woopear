import { graphqlService } from '$lib/models/graphql/graphql.service';
import { contactQuery } from '../queries/contact.query';
import type { IContactReceved } from '../types/contact.type';
import { contactGetter } from './contact.getter';
import { contactMutation } from './contact.mutation';

export const contactApi = {
	/**
	 * recupere le contact callAPi
	 */
	getContact: async (): Promise<void> => {
		// sub au store contact
		const c = contactGetter.getterContact();

		// si contact n'est pas renseigné
		if ('id' in c === false) {
			// recupere contact
			const { contact } = await graphqlService.request<IContactReceved>(contactQuery.getContact);

			// test si error
			if (!contact) {
				console.log('pas de partie contact');
			}

			// set contact
			contactMutation.setContact(contact);
		}
	}
};
