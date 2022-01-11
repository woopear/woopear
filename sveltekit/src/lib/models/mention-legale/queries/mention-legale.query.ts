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
	`,

	/**
	 * creation mention legale
	 */
	addMention: gql`
		mutation addMention($mentionLegale: MentionlegaleInput) {
			createMentionlegale(input: { data: $mentionLegale }) {
				mentionlegale {
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
		}
	`,

	/**
	 * requete pour modifier une mention
	 */
	updateMention: gql`
		mutation updateMention($id: ID!, $updatedMention: editMentionlegaleInput) {
			updateMentionlegale(input: { where: { id: $id }, data: $updatedMention }) {
				mentionlegale {
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
		}
	`,

	/**
	 * request pour supprimer une mention
	 */
	deleteMentionLegale: gql`
		mutation deleteMention($id: ID!) {
			deleteMentionlegale(input: { where: { id: $id } }) {
				mentionlegale {
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
		}
	`
};
