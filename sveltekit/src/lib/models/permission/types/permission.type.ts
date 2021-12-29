import type { IRole } from '$lib/models/role/types/role.type';

/**
 * interface des permissions
 */
export interface IPermission {
	id?: string;
	type?: string;
	controller?: string;
	action?: string;
	policy?: string;
	enable?: boolean;
	role?: IRole;
}
