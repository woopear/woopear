import { gql } from 'graphql-request';

export const connexionQuery = {
	/**
	 * connexion user
	 */
	login: gql`
		mutation Login($identifier: String!, $password: String!) {
			login(input: { identifier: $identifier, password: $password }) {
				user {
					id
					username
					email
					confirmed
					blocked
					role {
						id
						name
						description
						type
					}
				}
				jwt
			}
		}
	`
};
