import { gql } from 'graphql-request';

export const serviceQuery = {
	/**
	 * query pour recuperer les services
	 */
	getServices: gql`
		query getServices {
			services {
				id
				name
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
