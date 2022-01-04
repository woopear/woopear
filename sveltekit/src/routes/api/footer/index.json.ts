import { footerQuery } from '$lib/models/footer/queries/footer.query';
import type { IFooterReceved } from '$lib/models/footer/types/footer.type';
import { graphqlServiceBack } from '$lib/models/graphql/graphql.service';
import type { IResponseVite } from 'src/global';

export const get = async (): Promise<IResponseVite> => {
	try {
		// recupere le footer
		const { footer } = await graphqlServiceBack.request<IFooterReceved>(footerQuery.getFooter);

		return {
			status: 200,
			body: {
				footer
			}
		};
	} catch (error) {
		return {
			status: 500,
			body: {
				error
			}
		};
	}
};
