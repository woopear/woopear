import type { IPresentation } from '../types/presentation.type';
import { presentationStore } from './presentation.store';

export const presentationMutation = {
	/**
	 * set presentation
	 */
	setPresentation: (presentation: IPresentation): void => {
		presentationStore.update((n) => {
			n.presentation = presentation;
			return n;
		});
	}
};
