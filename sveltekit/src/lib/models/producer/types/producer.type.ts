import type { IImage } from '$lib/models/image/types/image.type';
import type { ITeam } from '$lib/models/team/types/team.type';

export interface IProducer {
	id?: string;
	fullName?: string;
	title?: string;
	description?: string;
	image?: IImage;
	team?: ITeam;
}
