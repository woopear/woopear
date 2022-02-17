// nos variable du .env
interface ImportMetaEnv {
  readonly VITE_API_KEY: string;
  readonly VITE_AUTH_DOMAIN: string;
  readonly VITE_PROJECT_ID: string;
  readonly VITE_STORAGE_BUCKET: string;
  readonly VITE_MESSAGING_SENDER_ID: string;
  readonly VITE_APP_ID: string;
  readonly VITE_MEASUREMENT_ID: string;
}

// ajoute notre interface qui contiendra nos variable dans le meta de import
interface ImportMeta {
  readonly env: ImportMetaEnv;
}
