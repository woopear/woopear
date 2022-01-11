import { articleMentionAction } from './stores/article-mention.action';
import { articleMentionApi } from './stores/article-mention.api';
import { articleMentionGetter } from './stores/article-mention.getter';
import { articleMentionMutation } from './stores/article-mention.mutation';

export const articleMentionService = {
	...articleMentionGetter,
	...articleMentionMutation,
	...articleMentionApi,
	...articleMentionAction
};
