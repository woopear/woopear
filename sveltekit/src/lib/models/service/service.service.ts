import { serviceAction } from './stores/service.action';
import { serviceApi } from './stores/service.api';
import { serviceGetter } from './stores/service.getter';
import { serviceMutation } from './stores/service.mutation';

export const serviceService = {
	...serviceGetter,
	...serviceMutation,
	...serviceAction,
	...serviceApi
};
