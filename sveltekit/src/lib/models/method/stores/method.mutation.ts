import type { IMethod } from '../types/method.type';
import { methodStore } from './method.store';

export const methodMutation = {
	/**
	 * set store method
	 */
	setMethod: (method: IMethod): void => {
		methodStore.update((n) => {
			n.method = method;
			return n;
		});
	}
};
