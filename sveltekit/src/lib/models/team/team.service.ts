import { teamAction } from './stores/team.action';
import { teamApi } from './stores/team.api';
import { teamGetter } from './stores/team.getter';
import { teamMutation } from './stores/team.mutation';

export const teamService = {
	...teamGetter,
	...teamMutation,
	...teamAction,
	...teamApi
};
