/// <reference types="vite/client" />

interface ImportMetaEnv {
	readonly VITE_GRAPHQL_STRAPI_FRONT: string;
	readonly VITE_URL_API_IMG: string;
	readonly VITE_URL_API: string;
}

interface ImportMeta {
	readonly env: ImportMetaEnv;
}
