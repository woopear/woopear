import type { IArticleMention } from '../types/article-mention.type';
import { articleMentionStore } from './article-mention.store';

export const articleMentionMutation = {
	/**
	 * set store articleMentions
	 */
	setArticleMentions: (articleMentions: IArticleMention[]): void => {
		articleMentionStore.update((n) => {
			n.articleMentions = articleMentions;
			return n;
		});
	},

	/**
	 * ajoute un articleMention au store articleMention
	 * @param value => objet articleMention
	 */
	addArticleMention: (value: IArticleMention): void => {
		articleMentionStore.update((n) => {
			// si la mention existe deja on l'enleve
			n.articleMentions = n.articleMentions.filter((el) => el !== value);
			n.articleMentions = [...n.articleMentions, value];
			return n;
		});
	},

	/**
	 * supprimer l'articleMention du store articleMention
	 * @param id => id de l'articleMention
	 */
	removeArticleMention: (id: string): void => {
		articleMentionStore.update((n) => {
			// si la mention existe deja on l'enleve
			n.articleMentions = n.articleMentions.filter((el) => el.id !== id);
			return n;
		});
	}
};
