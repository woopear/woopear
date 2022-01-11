import { gql } from 'graphql-request';

export const userQuery = {
	/**
	 * recuperation user avec son id
	 */
	getUserCurrent: gql`
		query getUserCurrent($id: ID!) {
			user(id: $id) {
				id
				username
				email
				provider
				confirmed
				blocked
				role {
					name
					description
					type
				}
				avatar {
					id
					name
					alternativeText
					url
					formats
				}
				adresse
				codePost
				city
				phoneNumber
			}
		}
	`
};
