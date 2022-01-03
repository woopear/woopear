import type { ILogin } from '../types/connexion.type';
import { connexionStore } from './connexion.store';

export const connexionGetter = {
	/**
	 * sub currentLogin
	 */
	getterCurrentLogin: (): ILogin => {
		let c: ILogin;
		connexionStore.subscribe((v) => (c = v.currentLogin));
		return c;
	}
};
