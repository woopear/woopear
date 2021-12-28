import type { IFooter } from '../types/footer.type';
import { footerStore } from './footer.store';

export const footerMutation = {
	/**
	 * set footer
	 */
	setFooter: (footer: IFooter): void => {
		footerStore.update((n) => {
			n.footer = footer;
			return n;
		});
	}
};
