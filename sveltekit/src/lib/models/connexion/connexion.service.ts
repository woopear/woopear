import { connexionAction } from './stores/connexion.action';
import { connexionApi } from './stores/connexion.api';
import { connexionGetter } from './stores/connexion.getter';
import { connexionMutation } from './stores/connexion.mutation';

export const connexionService = {
	...connexionGetter,
	...connexionMutation,
	...connexionAction,
	...connexionApi
};
