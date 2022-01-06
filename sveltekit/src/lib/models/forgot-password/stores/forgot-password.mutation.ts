import { forgotPasswordStore } from './forgot-password.store';

export const forgotPasswordMutation = {
	/**
	 * set store forgotPassword
	 */
	setForgotPassword: (forgotPassword: boolean): void => {
		forgotPasswordStore.update((n) => {
			n.forgotPassword = forgotPassword;
			return n;
		});
	}
};
