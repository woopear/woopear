import type { IPresentation } from '../types/presentation.type';
import { presentationStore } from './presentation.store';

export const presentationGetter = {
	/**
	 * sub à presentation
	 */
	getterPresentation: (): IPresentation => {
		let p: IPresentation;
		presentationStore.subscribe((v) => (p = v.presentation));
		return p;
	}
};
