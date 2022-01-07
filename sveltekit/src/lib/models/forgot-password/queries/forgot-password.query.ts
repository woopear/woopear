import { gql } from 'graphql-request';

export const forgotPasswordQuery = {
	/**
	 * modification du mot de passe
	 */
	forgotPassword: gql`
		mutation forgotPassword($password: String!, $passwordConfirmation: String!, $code: String!) {
			resetPassword(password: $password, passwordConfirmation: $passwordConfirmation, code: $code) {
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
