import type { IImage } from '$lib/models/image/types/image.type';

/**
 * interface techno
 */
export interface ITechno {
	id?: string;
	name?: string;
	image?: IImage;
}

/**
 * interface pour l'bjet reçus par graphql pour toutes les technos
 */
export interface ITechnosReceved {
	technos: ITechno[];
}

/**
 * interface pour l'bjet reçus par graphql pour une techno
 */
export interface ITechnoReceved {
	techno: ITechno;
}
