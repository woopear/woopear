import type { IProduct } from '../types/product.type';
import { productStore } from './product.store';

export const productMutation = {
	/**
	 * set le store products
	 */
	setProducts: (value: IProduct[]): void => {
		productStore.update((n) => {
			n.products = value;
			return n;
		});
	}
};
