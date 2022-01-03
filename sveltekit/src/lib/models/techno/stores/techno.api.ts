import { errorService } from '$lib/models/error/error.service';
import { graphqlService } from '$lib/models/graphql/graphql.service';
import { technoQuery } from '../queries/techno.query';
import type { ITechnosReceved } from '../types/techno.type';
import { technoGetter } from './techno.getter';
import { technoMutation } from './techno.mutation';

export const technoApi = {
	/**
	 * recupere tous les technos
	 */
	getTechnos: async (): Promise<void> => {
		// sub technos
		const t = technoGetter.getterTechno();

		// si pas initialisé
		if (t === null || t.length === 0) {
			// recuperation
			const { technos } = await graphqlService.request<ITechnosReceved>(technoQuery.getTechnos);

			// test si error
			if (!technos) {
				const message = 'il y a eu un probleme à la recuperation du composant technos';
				errorService.addNewError(message);
				throw new Error(message);
			}

			// set store techno
			technoMutation.setTechnos(technos);
		}
	}
};
