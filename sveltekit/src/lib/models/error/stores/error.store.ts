import { writable } from 'svelte/store';

export const errorStore = writable({
	error: [] as string[]
});
