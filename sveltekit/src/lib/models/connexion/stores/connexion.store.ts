import { writable } from 'svelte/store';
import type { ILogin } from '../types/connexion.type';

export const connexionStore = writable({
	currentLogin: {} as ILogin
});
