import { graphqlService } from '$lib/models/graphql/graphql.service';
import { serviceQuery } from '../queries/service.query';
import type { IServicesReceved } from '../types/service.type';
import { serviceGetter } from './service.getter';
import { serviceMutation } from './service.mutation';

export const serviceApi = {
	/**
	 * recupere tous les services
	 */
	getServices: async (): Promise<void> => {
		// sub store service
		const s = serviceGetter.getterServices();

		// si store service est vide
		if (s.length === 0) {
			const { services } = await graphqlService.request<IServicesReceved>(serviceQuery.getServices);

			serviceMutation.setServices(services);
		}
	}
};
