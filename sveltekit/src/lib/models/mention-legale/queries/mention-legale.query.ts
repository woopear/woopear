import { gql } from 'graphql-request';

export const mentionLegaleQuery = {
	/**
	 * recuperer toutes les mention legale
	 */
	getAllMentions: gql`
		query getAllMentions {
			mentionlegales {
				id
				created_at
				updated_at
				activate
				published_at
				articlementions {
					id
					created_at
					updated_at
					title
					subTitle
					content
					published_at
				}
			}
		}
	`
};
