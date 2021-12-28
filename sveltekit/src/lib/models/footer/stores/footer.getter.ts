import type { IFooter } from '../types/footer.type';
import { footerStore } from './footer.store';

export const footerGetter = {
	/**
	 * sub au footer
	 */
	getterFooter: (): IFooter => {
		let f: IFooter;
		footerStore.subscribe((v) => (f = v.footer));
		return f;
	}
};
