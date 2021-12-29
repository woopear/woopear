import { errorService } from '$lib/models/error/error.service';
import { graphqlService } from '$lib/models/graphql/graphql.service';
import { methodQuery } from '../queries/method.query';
import type { IMethodReceved } from '../types/method.type';
import { methodGetter } from './method.getter';
import { methodMutation } from './method.mutation';

export const methodApi = {
	/**
	 * recupere la method
	 */
	getMethod: async (): Promise<void> => {
		// sub au store method
		const m = methodGetter.getterMethod();

		// si pas encore initialiser
		if (m === null || 'id' in m === false) {
			// recuperation
			const { method } = await graphqlService.request<IMethodReceved>(methodQuery.getMethod);

			// test si erreur
			if (!method) {
				const message = "Aucune methode n'est renseignée";
				errorService.addNewError(message);
			}

			// set store
			methodMutation.setMethod(method);
		}
	}
};
