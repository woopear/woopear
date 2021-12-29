import type { IPermission } from '$lib/models/permission/types/permission.type';
import type { IUser } from '$lib/models/users/types/user.type';

/**
 * interface role
 */
export interface IRole {
	id?: string;
	name?: string;
	description?: string;
	type?: string;
	permissions?: IPermission[];
	users?: IUser[];
}
