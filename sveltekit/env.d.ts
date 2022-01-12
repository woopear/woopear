/// <reference types="vite/client" />

interface ImportMetaEnv {
	readonly VITE_GRAPHQL_STRAPI_FRONT: string;
	readonly VITE_GRAPHQL_STRAPI_BACK: string;
	readonly VITE_URL_API_IMG: string;
	readonly VITE_URL_API: string;
	readonly VITE_GRAPHQL_FAUNA: string;
	readonly VITE_SECRET_PUBLIC_FAUNA: string;
}

interface ImportMeta {
	readonly env: ImportMetaEnv;
}
