import { gql } from 'graphql-request';

export const contactQuery = {
	/**
	 * recupere la partie contact
	 */
	getContact: gql`
		query getContact {
			contact {
				id
				phoneNumber
				info
				address
				email
				created_at
				updated_at
			}
		}
	`
};
