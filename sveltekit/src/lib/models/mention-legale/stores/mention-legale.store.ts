import { writable } from 'svelte/store';
import type { IMention } from '../types/mention-legale.type';

export const mentionLegaleStore = writable({
	mentionLegales: [] as IMention[],
	mentionLegaleActivate: {} as IMention
});
