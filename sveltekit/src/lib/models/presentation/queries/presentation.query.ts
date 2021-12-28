import { gql } from 'graphql-request';

export const presentationQuery = {
	/**
	 * recupere presentation
	 */
	getPresentation: gql`
		query getPresentation {
			presentation {
				id
				title
				subTitle
				description
				image {
					id
					name
					alternativeText
					url
				}
				created_at
				updated_at
			}
		}
	`
};
