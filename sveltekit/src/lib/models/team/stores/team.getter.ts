import type { ITeam } from '../types/team.type';
import { teamStore } from './team.store';

export const teamGetter = {
	/**
	 * sub store team
	 */
	getterTeam: (): ITeam => {
		let t: ITeam;
		teamStore.subscribe((v) => (t = v.team));
		return t;
	}
};
