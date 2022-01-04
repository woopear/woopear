import { graphqlServiceBack } from '$lib/models/graphql/graphql.service';
import { presentationQuery } from '$lib/models/presentation/queries/presentation.query';
import type { IPresentationReceved } from '$lib/models/presentation/types/presentation.type';
import type { IResponseVite } from 'src/global';

export const get = async (): Promise<IResponseVite> => {
	try {
		// recupere le footer
		const { presentation } = await graphqlServiceBack.request<IPresentationReceved>(
			presentationQuery.getPresentation
		);

		return {
			status: 200,
			body: {
				presentation
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
