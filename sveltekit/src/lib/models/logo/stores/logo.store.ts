import { browser } from '$app/env';
import { writable } from 'svelte/store';

export const logoStore = writable({
	darkMode:
		browser && localStorage.getItem('dark') ? JSON.parse(localStorage.getItem('dark')) : false
});
