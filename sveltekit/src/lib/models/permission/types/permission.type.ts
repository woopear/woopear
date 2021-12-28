import type { IRole } from '$lib/models/role/types/role.type';

export interface IPermission {
	id?: string;
	type?: string;
	controller?: string;
	action?: string;
	policy?: string;
	enable?: boolean;
	role?: IRole;
}
