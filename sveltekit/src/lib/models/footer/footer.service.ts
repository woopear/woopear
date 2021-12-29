import { footerAction } from './stores/footer.action';
import { footerApi } from './stores/footer.api';
import { footerGetter } from './stores/footer.getter';
import { footerMutation } from './stores/footer.mutation';

export const footerService = {
	...footerGetter,
	...footerMutation,
	...footerAction,
	...footerApi
};
