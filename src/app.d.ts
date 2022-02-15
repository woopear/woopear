import type { IUser } from '$lib/modules/user/user.type';
/// <reference types="@sveltejs/kit" />

// See https://kit.svelte.dev/docs/typescript
// for information about these interfaces
declare namespace App {
  interface Locals {}

  interface Platform {}

  interface Session {
    user: IUser;
  }

  interface Stuff {}
}
