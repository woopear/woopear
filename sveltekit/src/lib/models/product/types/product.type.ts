import type { IImage } from '$lib/models/image/types/image.type';

export interface IProduct {
	id?: string;
	name?: string;
	description?: string;
	type?: string;
	urlLink?: string;
	image?: IImage;
}

export interface IProductsReceved {
	products: IProduct[];
}

export interface IProductReceved {
	product: IProduct;
}
