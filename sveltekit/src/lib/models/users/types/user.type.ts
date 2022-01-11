import type { IImage } from '$lib/models/image/types/image.type';
import type { IRole } from '$lib/models/role/types/role.type';

/**
 * interface user
 */
export interface IUser {
	id?: string;
	username?: string;
	email?: string;
	provider?: string;
	password?: string;
	resetPasswordToken?: string;
	confirmationToken?: string;
	confirmed?: boolean;
	blocked?: boolean;
	role?: IRole;
	avatar?: IImage;
	adresse?: string;
	codePost?: string;
	city?: string;
	phoneNumber?: string;
}

/**
 * interface pour l'bjet reçus par graphql pour tout les user
 */
export interface IUsersReceved {
	users: IUser[];
}

/**
 * interface pour l'bjet reçus par graphql pour un user
 */
export interface IUserReceved {
	user: IUser;
}
