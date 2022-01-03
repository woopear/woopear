import { writable } from 'svelte/store';
import type { ITechno } from '../types/techno.type';

export const technoStore = writable({
	technos: [] as ITechno[]
});
