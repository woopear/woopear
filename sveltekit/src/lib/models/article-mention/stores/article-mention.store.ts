import { writable } from 'svelte/store';
import type { IArticleMention } from '../types/article-mention.type';

export const articleMentionStore = writable({
	articleMentions: [] as IArticleMention[]
});
