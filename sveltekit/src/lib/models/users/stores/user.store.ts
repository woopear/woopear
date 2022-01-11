import { writable } from 'svelte/store';
import type { IUser } from '../types/user.type';

export const userStore = writable({
	userCurrent: {} as IUser
});
