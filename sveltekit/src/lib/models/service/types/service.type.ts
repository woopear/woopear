import type { IImage } from '$lib/models/image/types/image.type';

export interface IService {
	id?: string;
	name?: string;
	description?: string;
	image?: IImage;
}

export interface IServicesReceved {
	services: IService[];
}

export interface IServiceReceved {
	service: IService;
}
