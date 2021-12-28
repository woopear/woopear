import type { IProducer } from '$lib/models/producer/types/producer.type';

export interface ITeam {
	id?: string;
	title?: string;
	description?: string;
	producers?: IProducer[];
}
