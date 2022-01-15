import { conditionGeneAction } from './stores/condition-gene.action';
import { conditionGeneApi } from './stores/condition-gene.api';
import { conditionGeneGetter } from './stores/condition-gene.getter';
import { conditionGeneMutation } from './stores/condition-gene.mutation';

export const conditionGeneService = {
	...conditionGeneGetter,
	...conditionGeneMutation,
	...conditionGeneApi,
	...conditionGeneAction
};
