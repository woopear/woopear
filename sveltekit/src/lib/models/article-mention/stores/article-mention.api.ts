import { graphqlService } from '$lib/models/graphql/graphql.service';
import { mentionLegaleService } from '$lib/models/mention-legale/mention-legale.service';
import { articleMentionQuery } from '../queries/article-mention.query';
import type {
	IArticleMention,
	IArticleMentionDeleteReceved,
	IArticleMentionReceved,
	IArticleMentionsReceved
} from '../types/article-mention.type';
import { articleMentionMutation } from './article-mention.mutation';

export const articleMentionApi = {
	/**
	 * recupere tout les article mention call api
	 */
	getAllArticleMentions: async (): Promise<void> => {
		// recupere tous les articles
		const { articlementions } = await graphqlService.request<IArticleMentionsReceved>(
			articleMentionQuery.getAllArticleMention
		);

		// si null ou undefined (vide pas d'erreur)
		if (!articlementions) {
			// error systeme (alert)
		}

		// set le store articleMentions
		articleMentionMutation.setArticleMentions(articlementions);
	},

	/**
	 * creation article mention
	 */
	createArticleMention: async (data): Promise<void> => {
		// creation article
		const { articlemention } = await graphqlService.request<IArticleMentionReceved>(
			articleMentionQuery.addArticleMention,
			{ data: data }
		);

		// si null ou undefined (vide pas d'erreur)
		if (!articlemention) {
			// error systeme (alert)
		}

		// ajoute article au store articleMention si existe il le remplace
		articleMentionMutation.addArticleMention(articlemention);
	},

	/**
	 * modification articleMention call api
	 */
	updateArticleMention: async (id: string, data: IArticleMention): Promise<void> => {
		const { articlemention } = await graphqlService.request<IArticleMentionReceved>(
			articleMentionQuery.updateArticleMention,
			{ id: id, updateArticleMention: data }
		);

		// si null ou undefined (vide pas d'erreur)
		if (!articlemention) {
			// error systeme (alert)
		}

		// ajoute article au store articleMention si existe il le remplace
		articleMentionMutation.addArticleMention(articlemention);
	},

	/**
	 * supprime articleMention call api
	 * @param id => id de l'articleMention
	 */
	delArticleMention: async (id: string): Promise<void> => {
		const { deleteArticlemention } = await graphqlService.request<IArticleMentionDeleteReceved>(
			articleMentionQuery.deleteArticleMention,
			{ id: id }
		);

		// si null ou undefined (vide pas d'erreur)
		if (!deleteArticlemention) {
			// error systeme (alert)
		}

		// on remove l'articlemention du store
		articleMentionMutation.removeArticleMention(deleteArticlemention.articlemention.id);

		// on remet à jour le store mentionLegale
		await mentionLegaleService.getAllMentionLegale();
	}
};
