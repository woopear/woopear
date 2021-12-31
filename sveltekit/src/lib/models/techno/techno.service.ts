import { technoAction } from './stores/techno.action';
import { technoApi } from './stores/techno.api';
import { technoGetter } from './stores/techno.getter';
import { technoMutation } from './stores/techno.mutation';

export const technoService = {
	...technoGetter,
	...technoMutation,
	...technoAction,
	...technoApi
};
