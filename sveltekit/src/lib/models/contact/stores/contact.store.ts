import { writable } from 'svelte/store';
import type { IContact } from '../types/contact.type';

export const contactStore = writable({
	contact: {} as IContact
});
