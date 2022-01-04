import { gql } from 'graphql-request';

export const teamQuery = {
	/**
	 * query pour recuperer toutes les teams + ces producers
	 */
	getTeams: gql`
		query getTeam {
			teams {
				id
				title
				description
				producers {
					id
					fullName
					title
					description
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
		}
	`
};
