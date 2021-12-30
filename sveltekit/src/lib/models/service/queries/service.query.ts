import { gql } from 'graphql-request';

export const serviceQuery = {
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
