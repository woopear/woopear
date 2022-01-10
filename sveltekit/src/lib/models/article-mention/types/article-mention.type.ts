/**
 * interface article mention
 */
export interface IArticleMention {
	id?: string;
	created_at?: string;
	updated_at?: string;
	title?: string;
	subTitle?: string;
	content?: string;
	published_at?: string;
}

/**
 * interface de tous les articles mentions reçus
 */
export interface IArticleMentionReceved {
	articlementions?: IArticleMention[];
}
