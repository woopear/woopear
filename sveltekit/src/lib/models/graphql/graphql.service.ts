import { GraphQLClient } from 'graphql-request';

const graphqlUrl = import.meta.env.VITE_GRAPHQL_STRAPI_FRONT;
const graphqlUrlBack = import.meta.env.VITE_GRAPHQL_STRAPI_BACK;

export const graphqlService = new GraphQLClient(graphqlUrl);
export const graphqlServiceBack = new GraphQLClient(graphqlUrlBack);
