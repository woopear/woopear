import type { IProducer } from '$lib/models/producer/types/producer.type';

/**
 * interface team
 */
export interface ITeam {
	id?: string;
	title?: string;
	description?: string;
	producers?: IProducer[];
}

/**
 * interface pour l'bjet reçus par graphql pour toutes les teams
 */
export interface ITeamsReceved {
	teams: ITeam[];
}

/**
 * interface pour l'bjet reçus par graphql pour une team
 */
export interface ITeamReceved {
	team: ITeam;
}
