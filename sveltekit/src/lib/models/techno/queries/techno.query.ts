import { gql } from 'graphql-request';

export const technoQuery = {
	/**
	 * query recupere toutes les technos
	 */
	getTechnos: gql`
		query getTechnos {
			technos {
				id
				name
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
