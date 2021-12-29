import { graphqlService } from '$lib/models/graphql/graphql.service';
import { footerService } from '../footer.service';
import { footerQuery } from '../queries/footer.query';
import type { IFooterReceved } from '../types/footer.type';
import { footerMutation } from './footer.mutation';

export const footerApi = {
	/**
	 * recupere le footer call api
	 */
	getFooter: async (): Promise<void> => {
		// sub footer
		const f = footerService.getterFooter();

		// si footer pas encore renseigné
		if ('copyright' in f === false) {
			// recupration
			const { footer } = await graphqlService.request<IFooterReceved>(footerQuery.getFooter);

			// test si error
			if (!footer) {
				console.log('footer est null');
			}

			// set le store
			footerMutation.setFooter(footer);
		}
	}
};
