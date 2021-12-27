import { logoMutation } from './logo.mutation';

export const logoAction = {
	/**
	 * active désactive le mode dark
	 */
	activateDisableDarkMode: (): void => {
		logoMutation.setReverseDarkMode();
	}
};
