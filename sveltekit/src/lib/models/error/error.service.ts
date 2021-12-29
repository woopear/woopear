import { errorAction } from './stores/error.action';
import { errorGetter } from './stores/error.getter';
import { errorMutation } from './stores/error.mutation';

export const errorService = {
	...errorGetter,
	...errorMutation,
	...errorAction
};
