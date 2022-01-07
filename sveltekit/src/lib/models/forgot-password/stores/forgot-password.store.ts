import { writable } from 'svelte/store';

export const forgotPasswordStore = writable({
	forgotPassword: false
});
