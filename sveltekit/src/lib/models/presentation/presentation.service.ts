import { presentationAction } from './stores/presentation.action';
import { presentationApi } from './stores/presentation.api';
import { presentationGetter } from './stores/presentation.getter';
import { presentationMutation } from './stores/presentation.mutation';

export const presentationService = {
	...presentationGetter,
	...presentationMutation,
	...presentationAction,
	...presentationApi
};
