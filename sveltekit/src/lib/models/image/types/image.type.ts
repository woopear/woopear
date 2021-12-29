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
	formats?: unknown;
	height?: number;
	width?: number;
	caption?: string;
	alternativeText?: string;
}
