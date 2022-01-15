import type { IConditionGene } from '$lib/models/condition-gene/types/condition-gene.type';
import type { IDateFauna } from '$lib/models/date-model/types/date-model.type';

/**
 * interface article general
 */
export interface IArticleGene extends IDateFauna {
	_id?: string;
	title?: string;
	subTitle?: string;
	content?: string;
	conditions?: IConditionGene[];
}
