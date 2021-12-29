import type { IImage } from '$lib/models/image/types/image.type';

/**
 * interface product
 */
export interface IProduct {
	id?: string;
	name?: string;
	description?: string;
	type?: string;
	urlLink?: string;
	image?: IImage;
}

/**
 * interface pour l'bjet reçus par graphql pour tout les products
 */
export interface IProductsReceved {
	products: IProduct[];
}

/**
 * interface pour l'bjet reçus par graphql pour un product
 */
export interface IProductReceved {
	product: IProduct;
}
