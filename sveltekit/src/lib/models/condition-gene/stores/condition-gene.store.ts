import { writable } from 'svelte/store';
import type { IConditionGene } from '../types/condition-gene.type';

export const conditionGeneStore = writable({
	conditionGenes: [] as IConditionGene[],
	conditoinGeneActivate: {} as IConditionGene
});
