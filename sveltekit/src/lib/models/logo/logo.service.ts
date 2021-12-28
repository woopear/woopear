import { logoAction } from './stores/logo.action';
import { logoGetter } from './stores/logo.getter';
import { logoMutation } from './stores/logo.mutation';

export const logoService = {
	...logoGetter,
	...logoMutation,
	...logoAction
};
