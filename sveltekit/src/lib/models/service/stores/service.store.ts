import { writable } from 'svelte/store';
import type { IService } from '../types/service.type';

export const serviceStore = writable({
	services: [] as IService[]
});
