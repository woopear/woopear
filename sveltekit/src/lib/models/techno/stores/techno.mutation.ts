import type { ITechno } from '../types/techno.type';
import { technoStore } from './techno.store';

export const technoMutation = {
	/**
	 * set le store technos
	 */
	setTechnos: (technos: ITechno[]): void => {
		technoStore.update((n) => {
			n.technos = technos;
			return n;
		});
	}
};
