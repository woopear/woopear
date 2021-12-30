import { writable } from 'svelte/store';
import type { ITeam } from '../types/team.type';

export const teamStore = writable({
	team: {} as ITeam
});
