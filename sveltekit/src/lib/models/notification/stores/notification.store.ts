import { writable } from 'svelte/store';

export const notificationStore = writable({
	notifications: [] as string[]
});
