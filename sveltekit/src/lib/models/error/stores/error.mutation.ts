import { errorStore } from './error.store';

export const errorMutation = {
	/**
	 * ajout nouvelle erreur
	 */
	addNewError: (value: string): void => {
		errorStore.update((n) => {
			// si l'erreur existe deja on l'enleve
			n.error = n.error.filter((el) => el !== value);
			n.error = [...n.error, value];
			return n;
		});
	},

	/**
	 * supprime une error
	 */
	removeError: (value: string): void => {
		errorStore.update((n) => {
			n.error = n.error.filter((el) => el !== value);
			return n;
		});
	},

	/**
	 * set le store error
	 */
	setError: (error: string[]): void => {
		errorStore.update((n) => {
			n.error = error;
			return n;
		});
	}
};
