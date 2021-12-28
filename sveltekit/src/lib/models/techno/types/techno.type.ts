import type { IImage } from '$lib/models/image/types/image.type';

export interface ITechno {
	id?: string;
	name?: string;
	image?: IImage;
}

export interface ITechnosReceved {
	technos: ITechno[];
}

export interface ITechnoReceved {
	techno: ITechno;
}
