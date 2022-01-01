export interface IFormatContent {
	name?: string;
	hash?: string;
	ext?: string;
	mime?: string;
	width?: number;
	height?: number;
	size?: number;
	url?: string;
}

export interface IFormat {
	thumbnail?: IFormatContent;
	large?: IFormatContent;
	medium?: IFormatContent;
	small?: IFormatContent;
}

/**
 * interface des images
 */
export interface IImage {
	id?: string;
	name?: string;
	url?: string;
	size?: number;
	mime?: string;
	ext?: string;
	hash?: string;
	formats?: IFormat;
	height?: number;
	width?: number;
	caption?: string;
	alternativeText?: string;
}
