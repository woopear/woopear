import { errorService } from '$lib/models/error/error.service';
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
		if (p === null || 'id' in p === false) {
			// recuperation
			const { presentation } = await graphqlService.request<IPresentationReceved>(
				presentationQuery.getPresentation
			);

			// test si error
			if (!presentation) {
				const message = 'il y a eu un probleme à la recuperation de la presentation';
				errorService.addNewError(message);
				throw new Error(message);
			}

			// set le store
			presentationMutation.setPresentation(presentation);
		}
	},
	updatePresentation: async (data):Promise<void> => {
		console.log(graphqlService.request);
		
		const {presentation} = await graphqlService.request<IPresentationReceved>(
			presentationQuery.updatePresentation
			);
			console.log('api', presentation);

		// test si error
		if (!presentation) {
			const message = 'il y a eu un probleme à la modification de la presentation';
			errorService.addNewError(message);
			throw new Error(message);
		}

		// set le store
		presentationMutation.setPresentation(presentation);
	}

	
};
