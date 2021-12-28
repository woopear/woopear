import { writable } from 'svelte/store';
import type { IPresentation } from '../types/presentation.type';

export const presentationStore = writable({
	presentation: {} as IPresentation
});
