import { productAction } from './stores/product.action';
import { productApi } from './stores/product.api';
import { productGetter } from './stores/product.getter';
import { productMutation } from './stores/product.mutation';

export const productService = {
	...productGetter,
	...productMutation,
	...productAction,
	...productApi
};
