import { forgotPasswordMutation } from './forgot-password.mutation';

export const forgotPasswordAction = {
	/**
	 * active forgotpassword
	 */
	activeForgotPassword: (): void => {
		forgotPasswordMutation.setForgotPassword(true);
	},

	/**
	 * active forgotpassword
	 */
	disableForgotPassword: (): void => {
		forgotPasswordMutation.setForgotPassword(false);
	}
};
