import { gql } from 'graphql-request';

export const methodQuery = {
	/**
	 * query pour recuperer la method avec ses steps
	 */
	getMethod: gql`
		query getMethod {
			method {
				id
				title
				description
				created_at
				updated_at
				steps {
					id
					title
					description
					position
					image {
						id
						name
						alternativeText
						url
					}
				}
			}
		}
	`
};
