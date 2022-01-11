import { graphqlService } from '$lib/models/graphql/graphql.service';
import { infoBulleService } from '$lib/models/info-bulle/info-bulle.service';
import { EInfoBulleError } from '$lib/models/info-bulle/types/info-bulle.enum';
import { mentionLegaleService } from '../mention-legale.service';
import { mentionLegaleQuery } from '../queries/mention-legale.query';
import type {
	IMention,
	IMentionDeleteReceved,
	IMentionReceved,
	IMentionsReceved
} from '../types/mention-legale.type';
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
	createMentionLegale: async (data: IMention, e: MouseEvent): Promise<void> => {
		// creation mention
		const { mentionlegale } = await graphqlService.request<IMentionReceved>(
			mentionLegaleQuery.addMention,
			{ mentionLegale: data }
		);

		// si null ou undefined (vide pas d'erreur)
		if (!mentionlegale) {
			// config info bulle
			infoBulleService.setInfoBubbleError(EInfoBulleError.CREATE_MENTIONLEGALE);
			infoBulleService.definePositionXInfoBubble(e, window.innerWidth);
			infoBulleService.definePositionYInfoBubble(e);
			throw new Error(EInfoBulleError.CONNEXION);
		}

		// ajout mention dans le store mention
		mentionLegaleMutation.addNewMentionLegale(mentionlegale);
	},

	/**
	 * modifie la mention dans l'api et dans le store
	 * @param id => id de la mention
	 * @param data => donnée à modifier
	 */
	updateMentionLegale: async (id: string, data: IMention, e: MouseEvent): Promise<void> => {
		// modification
		const { mentionlegale } = await graphqlService.request<IMentionReceved>(
			mentionLegaleQuery.updateMention,
			{
				id: id,
				updatedMention: data
			}
		);

		// si null ou undefined (vide pas d'erreur)
		if (!mentionlegale) {
			// config info bulle
			infoBulleService.setInfoBubbleError(EInfoBulleError.UPDATE_MENTIONLEGALE);
			infoBulleService.definePositionXInfoBubble(e, window.innerWidth);
			infoBulleService.definePositionYInfoBubble(e);
			throw new Error(EInfoBulleError.CONNEXION);
		}

		// ajout mention dans le store mention, si existe deja cela la remplace
		mentionLegaleMutation.addNewMentionLegale(mentionlegale);
	},

	/**
	 * delte mention legale call api
	 */
	delMentionLegale: async (id: string, e: MouseEvent): Promise<void> => {
		// remove de la mention dans api
		const { deleteMentionlegale } = await graphqlService.request<IMentionDeleteReceved>(
			mentionLegaleQuery.deleteMentionLegale,
			{ id: id }
		);

		// si null ou undefined (vide pas d'erreur)
		if (!deleteMentionlegale) {
			// config info bulle
			infoBulleService.setInfoBubbleError(EInfoBulleError.DELETE_MENTIONLEGALE);
			infoBulleService.definePositionXInfoBubble(e, window.innerWidth);
			infoBulleService.definePositionYInfoBubble(e);
			throw new Error(EInfoBulleError.CONNEXION);
		}

		// on remove la mention du store
		mentionLegaleService.removeMentionLegale(deleteMentionlegale.mentionlegale.id);
	}
};
