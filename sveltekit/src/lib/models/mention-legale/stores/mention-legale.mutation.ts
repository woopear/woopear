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
	}
};
