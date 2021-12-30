import { graphqlService } from '$lib/models/graphql/graphql.service';
import { serviceQuery } from '../queries/service.query';
import type { IServicesReceved } from '../types/service.type';
import { serviceMutation } from './service.mutation';

export const serviceApi = {
	/**
	 * recupere tous les services
	 */
	getServices: async (): Promise<void> => {
		const { services } = await graphqlService.request<IServicesReceved>(serviceQuery.getServices);

		serviceMutation.setServices(services);
	}
};
