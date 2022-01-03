import { writable } from 'svelte/store';
import type { IProduct } from '../types/product.type';

export const productStore = writable({
	products: [] as IProduct[]
});
