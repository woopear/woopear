import type { ITeam } from '../types/team.type';
import { teamStore } from './team.store';

export const teamMutation = {
	/**
	 * set le store team
	 */
	setTeam: (team: ITeam): void => {
		teamStore.update((n) => {
			n.team = team;
			return n;
		});
	}
};
