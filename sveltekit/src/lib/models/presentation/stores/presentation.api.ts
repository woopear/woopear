import { graphqlService } from '$lib/models/graphql/graphql.service';
import { presentationQuery } from '../queries/presentation.query';
import type { IPresentationReceved } from '../types/presentation.type';
import { presentationGetter } from './presentation.getter';
import { presentationMutation } from './presentation.mutation';

export const presentationApi = {
	/**
	 * recupere presentation call api
	 */
	getPresentation: async (): Promise<void> => {
		// sub à presentation
		const p = presentationGetter.getterPresentation();

		// si presentation n'est pas encore initialiser
		if ('id' in p === false) {
			// recuperation
			const { presentation } = await graphqlService.request<IPresentationReceved>(
				presentationQuery.getPresentation
			);

			// test si error
			if (!presentation) {
				console.log('pas de presentation');
			}

			// set le store
			presentationMutation.setPresentation(presentation);
		}
	}
};
