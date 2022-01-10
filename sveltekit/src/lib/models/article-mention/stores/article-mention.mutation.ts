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

	addArticleMention: (value: IArticleMention): void => {
		articleMentionStore.update((n) => {
			// si la mention existe deja on l'enleve
			n.articleMentions = n.articleMentions.filter((el) => el !== value);
			n.articleMentions = [...n.articleMentions, value];
			return n;
		});
	}
};
