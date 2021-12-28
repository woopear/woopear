import { logoStore } from './logo.store';

export const logoMutation = {
	/**
	 * set la valeur de darkMode par son inverse
	 */
	setReverseDarkMode: (): void => {
		logoStore.update((n) => {
			n.darkMode = !n.darkMode;
			localStorage.setItem('dark', n.darkMode);
			return n;
		});
	}
};
