import { gql } from 'graphql-request';

export const footerQuery = {
	/**
	 * recupere le footer
	 */
	getFooter: gql`
		query getFooter {
			footer {
				id
				copyright
				created_at
				updated_at
			}
		}
	`
};
