import type { IProducer } from '$lib/models/producer/types/producer.type';

export interface ITeam {
	id?: string;
	title?: string;
	description?: string;
	producers?: IProducer[];
}

export interface ITeamsReceved {
	teams: ITeam[];
}

export interface ITeamReceved {
	team: ITeam;
}
