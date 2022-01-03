import { writable } from 'svelte/store';
import type { IMethod } from '../types/method.type';

export const methodStore = writable({
	method: {} as IMethod
});
