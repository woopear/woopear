import type { IImage } from '$lib/models/image/types/image.type';
import type { ITeam } from '$lib/models/team/types/team.type';

/**
 * interface producer
 */
export interface IProducer {
	id?: string;
	fullName?: string;
	title?: string;
	description?: string;
	image?: IImage;
	team?: ITeam;
}

/**
 * interface pour l'bjet reçus par graphql pour tous les producers
 */
export interface IProducersReceved {
	producers: IProducer[];
}

/**
 * interface pour l'bjet reçus par graphql pour un producer
 */
export interface IProducerReceved {
	producer: IProducer;
}
