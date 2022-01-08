import { userAction } from './stores/user.action';
import { userApi } from './stores/user.api';
import { userGetter } from './stores/user.getter';
import { userMutation } from './stores/user.mutation';

export const userService = {
	...userGetter,
	...userMutation,
	...userApi,
	...userAction
};
