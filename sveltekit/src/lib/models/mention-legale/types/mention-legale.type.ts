import type { IArticleMention } from '$lib/models/article-mention/types/article-mention.type';
import type { IDateModel } from '$lib/models/date-model/types/date-model.type';

/**
 * interface mention legale
 */
export interface IMention extends IDateModel {
	id?: string;
	activate?: boolean;
	published_at?: string;
	articlementions?: IArticleMention[];
}

/**
 * interface pour toute les mention legale reçus
 */
export interface IMentionsReceved {
	mentionlegales?: IMention[];
}

/**
 * interface pour une mention legale reçus
 */
export interface IMentionReceved {
	mentionlegale?: IMention;
}

/**
 * interface delete mention reçus
 */
export interface IMentionDeleteReceved {
	deleteMentionlegale?: IMentionReceved;
}
