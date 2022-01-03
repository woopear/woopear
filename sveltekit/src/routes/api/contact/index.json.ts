import { contactQuery } from '$lib/models/contact/queries/contact.query';
import type { IContactReceved } from '$lib/models/contact/types/contact.type';
import { graphqlServiceBack } from '$lib/models/graphql/graphql.service';
import type { IResponseVite } from 'src/global';

export const get = async (): Promise<IResponseVite> => {
	try {
		// recupere le footer
		const { contact } = await graphqlServiceBack.request<IContactReceved>(contactQuery.getContact);

		return {
			status: 200,
			body: {
				contact
			}
		};
	} catch (error) {
		return {
			status: 500,
			body: {
				error
			}
		};
	}
};
