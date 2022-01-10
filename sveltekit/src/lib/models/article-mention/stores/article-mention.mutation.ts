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
	}
};
