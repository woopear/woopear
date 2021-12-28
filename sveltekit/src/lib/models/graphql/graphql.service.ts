import { GraphQLClient } from 'graphql-request';

const graphqlUrl = import.meta.env.VITE_GRAPHQL_STRAPI_FRONT;

export const graphqlService = new GraphQLClient(graphqlUrl);
