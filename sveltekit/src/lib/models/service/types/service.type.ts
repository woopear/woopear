import type { IImage } from '$lib/models/image/types/image.type';

/**
 * interface service
 */
export interface IService {
	id?: string;
	name?: string;
	description?: string;
	image?: IImage;
}

/**
 * interface pour l'bjet reçus par graphql pour tout les services
 */
export interface IServicesReceved {
	services: IService[];
}

/**
 * interface pour l'bjet reçus par graphql pour un service
 */
export interface IServiceReceved {
	service: IService;
}
