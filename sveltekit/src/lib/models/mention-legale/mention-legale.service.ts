import { mentionLegaleAction } from './stores/mention-legale.action';
import { mentionLegaleApi } from './stores/mention-legale.api';
import { mentionLegaleGetter } from './stores/mention-legale.getter';
import { mentionLegaleMutation } from './stores/mention-legale.mutation';

export const mentionLegaleService = {
	...mentionLegaleGetter,
	...mentionLegaleMutation,
	...mentionLegaleAction,
	...mentionLegaleApi
};
