import type { IMention } from '../types/mention-legale.type';
import { mentionLegaleStore } from './mention-legale.store';

export const mentionLegaleMutation = {
	/**
	 * set store mentionLegales
	 */
	setMentionLegales: (mentions: IMention[]): void => {
		mentionLegaleStore.update((n) => {
			n.mentionLegales = mentions;
			return n;
		});
	},

	/**
	 * ajout nouvelle mention legale
	 */
	addNewMentionLegale: (value: IMention): void => {
		mentionLegaleStore.update((n) => {
			// si la mention existe deja on l'enleve
			n.mentionLegales = n.mentionLegales.filter((el) => el !== value);
			n.mentionLegales = [...n.mentionLegales, value];
			return n;
		});
	},

	/**
	 * remove mention du store mentionLegale
	 */
	removeMentionLegale: (id: string): void => {
		mentionLegaleStore.update((n) => {
			// si la mention existe deja on l'enleve
			n.mentionLegales = n.mentionLegales.filter((el) => el.id !== id);
			return n;
		});
	},

	/**
	 * set le store mentionLegaleActivate
	 */
	setMentionLegaleActivate: (mention: IMention): void => {
		mentionLegaleStore.update((n) => {
			n.mentionLegaleActivate = mention;
			return n;
		});
	}
};
