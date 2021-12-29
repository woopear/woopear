import { errorService } from '$lib/models/error/error.service';
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
				const errorMessage = 'La recuperation de la partie contact à échoué';
				errorService.addNewError(errorMessage);
				throw new Error(errorMessage);
			}

			// set contact
			contactMutation.setContact(contact);
		}
	}
};
