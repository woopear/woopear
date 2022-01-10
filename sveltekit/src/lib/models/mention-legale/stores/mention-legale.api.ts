import { graphqlService } from '$lib/models/graphql/graphql.service';
import { mentionLegaleQuery } from '../queries/mention-legale.query';
import type { IMentionsReceved } from '../types/mention-legale.type';
import { mentionLegaleMutation } from './mention-legale.mutation';

export const mentionLegaleApi = {
	/**
	 * recupere toute les mention legale
	 */
	getAllMentionLegale: async (): Promise<void> => {
		// recupere toute mention legale
		const { mentionlegales } = await graphqlService.request<IMentionsReceved>(
			mentionLegaleQuery.getAllMentions
		);

		// si null ou undefined (vide pas d'erreur)
		if (!mentionlegales) {
			// error systeme (alert)
		}

		// set le store
		mentionLegaleMutation.setMentionLegales(mentionlegales);
	}
};
