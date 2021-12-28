import type { IImage } from '$lib/models/image/types/image.type';
import type { IRole } from '$lib/models/role/types/role.type';

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
}

export interface IUsersReceved {
	users: IUser[];
}

export interface IUserReceved {
	user: IUser;
}
