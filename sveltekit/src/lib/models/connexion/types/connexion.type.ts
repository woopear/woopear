import type { IErrorReceved } from '$lib/models/error/types/error.type';
import type { IUser } from '$lib/models/users/types/user.type';

export interface ILogin {
	user: IUser;
	jwt: string;
}

export interface ILoginReceved extends IErrorReceved {
	login: ILogin;
}

export interface IConnextionObject {
	identifier: string;
	password: string;
}
