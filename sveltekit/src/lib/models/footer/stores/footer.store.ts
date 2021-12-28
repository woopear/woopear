import { writable } from 'svelte/store';
import type { IFooter } from '../types/footer.type';

export const footerStore = writable({
	footer: {} as IFooter
});
