import { graphqlService } from '$lib/models/graphql/graphql.service';
import { infoBulleService } from '$lib/models/info-bulle/info-bulle.service';
import { EInfoBulleError } from '$lib/models/info-bulle/types/info-bulle.enum';
import { mentionLegaleService } from '$lib/models/mention-legale/mention-legale.service';
import { articleMentionQuery } from '../queries/article-mention.query';
import type {
	IArticleMention,
	IArticleMentionCreateReceved,
	IArticleMentionDeleteReceved,
	IArticleMentionReceved,
	IArticleMentionsReceved,
	IArticleMentionUpdateReceved
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
	createArticleMention: async (data: IArticleMention, e: MouseEvent): Promise<void> => {
		// creation article
		const { createArticlemention } = await graphqlService.request<IArticleMentionCreateReceved>(
			articleMentionQuery.addArticleMention,
			{ data: data }
		);

		// si null ou undefined (vide pas d'erreur)
		if (!createArticlemention) {
			// config info bulle
			infoBulleService.setInfoBubbleError(EInfoBulleError.CREATE_ARTICLEMENTIONLEGALE);
			infoBulleService.definePositionXInfoBubble(e, window.innerWidth);
			infoBulleService.definePositionYInfoBubble(e);
			throw new Error(EInfoBulleError.CONNEXION);
		}

		// ajoute article au store articleMention si existe il le remplace
		articleMentionMutation.addArticleMention(createArticlemention.articlemention);
	},

	/**
	 * modification articleMention call api
	 */
	updateArticleMention: async (id: string, data: IArticleMention, e: MouseEvent): Promise<void> => {
		const { updateArticlemention } = await graphqlService.request<IArticleMentionUpdateReceved>(
			articleMentionQuery.updateArticleMention,
			{ id: id, updateArticleMention: data }
		);

		// si null ou undefined (vide pas d'erreur)
		if (!updateArticlemention) {
			// config info bulle
			infoBulleService.setInfoBubbleError(EInfoBulleError.UPDATE_ARTICLEMENTIONLEGALE);
			infoBulleService.definePositionXInfoBubble(e, window.innerWidth);
			infoBulleService.definePositionYInfoBubble(e);
			throw new Error(EInfoBulleError.CONNEXION);
		}

		// ajoute article au store articleMention si existe il le remplace
		articleMentionMutation.addArticleMention(updateArticlemention.articlemention);
	},

	/**
	 * supprime articleMention call api
	 * @param id => id de l'articleMention
	 */
	delArticleMention: async (id: string, e: MouseEvent): Promise<void> => {
		const { deleteArticlemention } = await graphqlService.request<IArticleMentionDeleteReceved>(
			articleMentionQuery.deleteArticleMention,
			{ id: id }
		);

		// si null ou undefined (vide pas d'erreur)
		if (!deleteArticlemention) {
			// config info bulle
			infoBulleService.setInfoBubbleError(EInfoBulleError.DELETE_ARTICLEMENTIONLEGALE);
			infoBulleService.definePositionXInfoBubble(e, window.innerWidth);
			infoBulleService.definePositionYInfoBubble(e);
			throw new Error(EInfoBulleError.CONNEXION);
		}

		// on remove l'articlemention du store
		articleMentionMutation.removeArticleMention(deleteArticlemention.articlemention.id);

		// on remet à jour le store mentionLegale
		await mentionLegaleService.getAllMentionLegale();
	}
};
