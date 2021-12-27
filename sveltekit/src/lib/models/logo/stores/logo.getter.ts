import { logoStore } from './logo.store';

export const logoGetter = {
	/**
	 * fonction qui sub au darkMode
	 * @returns le darkMode
	 */
	getterDarkMode: (): boolean => {
		let dark: boolean;
		logoStore.subscribe((v) => (dark = v.darkMode));
		return dark;
	}
};
