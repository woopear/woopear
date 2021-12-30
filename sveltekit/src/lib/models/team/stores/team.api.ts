import { errorService } from '$lib/models/error/error.service';
import { graphqlService } from '$lib/models/graphql/graphql.service';
import { teamQuery } from '../queries/team.query';
import type { ITeamsReceved } from '../types/team.type';
import { teamGetter } from './team.getter';
import { teamMutation } from './team.mutation';

export const teamApi = {
	/**
	 * recupere toute les team call api et affecte la premiere team
	 */
	getTeams: async (): Promise<void> => {
		// sub team
		const t = teamGetter.getterTeam();

		// si pas encore renseigné
		if (t === null || 'id' in t === false) {
			// recuperation
			const { teams } = await graphqlService.request<ITeamsReceved>(teamQuery.getTeams);

			// test si error
			if (!teams) {
				const message = 'il y a eu un probleme à la recuperation du composant équipe';
				errorService.addNewError(message);
				throw new Error(message);
			}

			// set store team
			teamMutation.setTeam(teams[0]);
			console.log(t);
		}
	}
};
