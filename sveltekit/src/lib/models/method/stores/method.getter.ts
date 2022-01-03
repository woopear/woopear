import type { IMethod } from '../types/method.type';
import { methodStore } from './method.store';

export const methodGetter = {
	/**
	 * sub store method
	 */
	getterMethod: (): IMethod => {
		let m: IMethod;
		methodStore.subscribe((v) => (m = v.method));
		return m;
	}
};
