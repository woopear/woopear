import { gql } from 'graphql-request';

export const productQuery = {
	/**
	 * requete pour recuperer tous les products
	 */
	getProducts: gql`
		query getProducts {
			products {
				id
				name
				description
				type
				urlLink
				image {
					id
					name
					alternativeText
					url
					formats
				}
				created_at
				updated_at
			}
		}
	`
};
