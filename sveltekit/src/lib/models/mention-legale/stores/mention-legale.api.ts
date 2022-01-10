import { graphqlService } from '$lib/models/graphql/graphql.service';
import { mentionLegaleQuery } from '../queries/mention-legale.query';
import type { IMention, IMentionReceved, IMentionsReceved } from '../types/mention-legale.type';
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
	},

	/**
	 * creation mention legale
	 */
	createMention: async (data: IMention): Promise<void> => {
		// creation mention
		const { mentionlegale } = await graphqlService.request<IMentionReceved>(
			mentionLegaleQuery.addMention,
			{ mentionLegale: data }
		);

		// si null ou undefined (vide pas d'erreur)
		if (!mentionlegale) {
			// error systeme (alert)
		}

		// ajout mention dans le store mention
		mentionLegaleMutation.addNewMention(mentionlegale);
	}
};
