import { gql } from 'graphql-request';

export const articleMentionQuery = {
	/**
	 * recuperation de tout les articles
	 */
	getAllArticleMention: gql`
		query getAllArticleMention {
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
	`,

	/**
	 * creation article mention
	 */
	addArticleMention: gql`
		mutation addArticleMention($data: ArticlementionInput) {
			createArticlemention(input: { data: $data }) {
				articlemention {
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
	 * modification article
	 */
	updateArticleMention: gql`
		mutation updateArticleMention($id: ID!, $updateArticleMention: editArticlementionInput) {
			updateArticlemention(input: { where: { id: $id }, data: $updateArticleMention }) {
				articlemention {
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
