import type { ITechno } from '../types/techno.type';
import { technoStore } from './techno.store';

export const technoGetter = {
	/**
	 * sub store technos
	 */
	getterTechno: (): ITechno[] => {
		let t: ITechno[];
		technoStore.subscribe((v) => (t = v.technos));
		return t;
	}
};
