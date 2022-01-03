import { errorService } from '$lib/models/error/error.service';
import { graphqlService } from '$lib/models/graphql/graphql.service';
import { productQuery } from '../queries/product.query';
import type { IProductsReceved } from '../types/product.type';
import { productGetter } from './product.getter';
import { productMutation } from './product.mutation';

export const productApi = {
	/**
	 * recupere tous les products
	 */
	getProducts: async (): Promise<void> => {
		// sub store products
		const p = productGetter.getterProducts();

		// si store products est vide
		if (p.length === 0) {
			// recuperation
			const { products } = await graphqlService.request<IProductsReceved>(productQuery.getProducts);

			// test si error
			if (!products) {
				const message = 'il y a eu un probleme à la recuperation du composant product';
				errorService.addNewError(message);
				throw new Error(message);
			}

			// set store product
			productMutation.setProducts(products);
		}
	}
};
