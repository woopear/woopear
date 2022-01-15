import type { IArticleGene } from '$lib/models/article-gene/types/article-gene.type';
import type { IDateFauna } from '$lib/models/date-model/types/date-model.type';

/**
 * interface condition genenral
 */
export interface IConditionGene extends IDateFauna {
	_id?: string;
	activate?: boolean;
	articles?: IArticleGene[];
}

/**
 * interface condition general reçus apres getAll
 */
export interface IConditionGeneAllReceved {
	allConditionGeneVente?: { data?: IConditionGene[] };
}

/**
 * interface condition general reçus apres getactivatecondition
 */
export interface IConditionGeneActivateReceved {
	conditionGeneVenteByActivate?: IConditionGene;
}

/**
 * interface condition general reçus apres creation
 */
export interface IConditionGeneCreateReceved {
	createConditionGeneVente?: IConditionGene;
}

/**
 * interface condition general reçus apres update
 */
export interface IConditionGeneUpdateReceved {
	updateConditionGeneVente?: IConditionGene;
}

/**
 * interface condition general reçus apres delete
 */
export interface IConditionGeneDeleteReceved {
	deleteConditionGeneVente?: IConditionGene;
}
