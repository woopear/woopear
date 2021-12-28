import { logoGetter } from './logo.getter';
import { logoMutation } from './logo.mutation';

export const logoAction = {
	/**
	 * active désactive le mode dark
	 */
	activateDisableDarkMode: (): void => {
		logoMutation.setReverseDarkMode();
		const dark = logoGetter.getterDarkMode();
		dark
			? document.getElementById('html').classList.add('dark')
			: document.getElementById('html').classList.remove('dark');
	}
};
