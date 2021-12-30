import type { IService } from '../types/service.type';
import { serviceStore } from './service.store';

export const serviceMutation = {
	/**
	 * set store service
	 */
	setServices: (services: IService[]): void => {
		serviceStore.update((n) => {
			n.services = services;
			return n;
		});
	}
};
