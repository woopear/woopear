import { forgotPasswordAction } from './stores/forgot-password.action';
import { forgotPasswordApi } from './stores/forgot-password.api';
import { forgotPasswordGetter } from './stores/forgot-password.getter';
import { forgotPasswordMutation } from './stores/forgot-password.mutation';

export const forgotPasswordService = {
	...forgotPasswordGetter,
	...forgotPasswordMutation,
	...forgotPasswordAction,
	...forgotPasswordApi
};
