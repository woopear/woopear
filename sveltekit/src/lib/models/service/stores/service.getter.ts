import type { IService } from '../types/service.type';
import { serviceStore } from './service.store';

export const serviceGetter = {
	/**
	 * sub store service
	 */
	getterServices: (): IService[] => {
		let s: IService[];
		serviceStore.subscribe((v) => (s = v.services));
		return s;
	}
};
