import { contactAction } from './stores/contact.action';
import { contactApi } from './stores/contact.api';
import { contactGetter } from './stores/contact.getter';
import { contactMutation } from './stores/contact.mutation';

export const contactService = {
	...contactGetter,
	...contactMutation,
	...contactAction,
	...contactApi
};
