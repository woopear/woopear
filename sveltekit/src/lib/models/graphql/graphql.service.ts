import { GraphQLClient } from 'graphql-request';

const graphqlUrl = import.meta.env.VITE_GRAPHQL_STRAPI_FRONT;
const graphqlUrlBack = import.meta.env.VITE_GRAPHQL_STRAPI_BACK;
const graphqlUrlFauna = import.meta.env.VITE_GRAPHQL_FAUNA;

export const graphqlService = new GraphQLClient(graphqlUrl);
export const graphqlServiceBack = new GraphQLClient(graphqlUrlBack);

export const graphQLClient = (token: string): GraphQLClient => {
	const secret = token || import.meta.env.VITE_SECRET_PUBLIC_FAUNA;

	return new GraphQLClient(graphqlUrlFauna, {
		headers: {
			authorization: `Bearer ${secret}`
			// 'X-Schema-Preview': 'partial-update-mutation', // move to `pages/index.js`
		}
	});
};
