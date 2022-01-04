import type { ILogin } from '../types/connexion.type';
import { connexionStore } from './connexion.store';

export const connexionMutation = {
	/**
	 * set currentLogin
	 */
	setCurrentLogin: (currentLogin: ILogin): void => {
		connexionStore.update((n) => {
			n.currentLogin = currentLogin;
			return n;
		});
	},

	/**
	 * reset currentLogin
	 */
	resetCurrentLogin: (): void => {
		connexionStore.update((n) => {
			n.currentLogin = {} as ILogin;
			return n;
		});
	}
};
