import { errorService } from '$lib/models/error/error.service';
import { graphqlService } from '$lib/models/graphql/graphql.service';
import { notificationService } from '$lib/models/notification/notification.service';
import { EMethodeFetch } from '$lib/providers/fetch/fetch.enum';
import { fetchProvider } from '$lib/providers/fetch/fetch.service';
import { contactQuery } from '../queries/contact.query';
import type {
	IContactReceved,
	IObjectSedMailResponseReceved,
	IObjectSendMail
} from '../types/contact.type';
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
	},

	/**
	 * envoie du mailConatct au backend
	 */
	sendMailContact: async (data: IObjectSendMail): Promise<void> => {
		// envoie mail
		const response = await fetchProvider.callApiSkillz<IObjectSedMailResponseReceved>(
			`${import.meta.env.VITE_URL_API}/emails`,
			EMethodeFetch.POST,
			fetchProvider.headersSample(),
			data
		);

		// si pas d'erreur on affiche une notification
		// sinon on affiche une erreur
		if (response.state) {
			notificationService.addNewNotification(response.message);
		} else {
			errorService.addNewError(response.message);
		}
	}
};
