import type { IProduct } from '../types/product.type';
import { productStore } from './product.store';

export const productGetter = {
	/**
	 * sub store products
	 */
	getterProducts: (): IProduct[] => {
		let p: IProduct[];
		productStore.subscribe((v) => (p = v.products));
		return p;
	}
};
