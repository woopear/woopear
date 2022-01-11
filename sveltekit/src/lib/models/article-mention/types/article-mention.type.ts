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
export interface IArticleMentionsReceved {
	articlementions?: IArticleMention[];
}

/**
 * interface d'un article reçus
 */
export interface IArticleMentionReceved {
	articlemention?: IArticleMention;
}

/**
 * interface article apres creation reçus
 */
export interface IArticleMentionCreateReceved {
	createArticlemention?: IArticleMentionReceved;
}

/**
 * interface article apres modification reçus
 */
export interface IArticleMentionUpdateReceved {
	updateArticlemention?: IArticleMentionReceved;
}

/**
 * interface suppression article reçus
 */
export interface IArticleMentionDeleteReceved {
	deleteArticlemention?: IArticleMentionReceved;
}
