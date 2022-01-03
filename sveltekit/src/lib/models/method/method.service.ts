import { methodAction } from './stores/method.action';
import { methodApi } from './stores/method.api';
import { methodGetter } from './stores/method.getter';
import { methodMutation } from './stores/method.mutation';

export const methodService = {
	...methodGetter,
	...methodMutation,
	...methodAction,
	...methodApi
};
