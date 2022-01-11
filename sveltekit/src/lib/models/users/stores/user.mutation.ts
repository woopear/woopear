import type { IUser } from '../types/user.type';
import { userStore } from './user.store';

export const userMutation = {
	/**
	 * set store userCurrent
	 */
	setUserCurrent: (userCurrent: IUser): void => {
		userStore.update((n) => {
			n.userCurrent = userCurrent;
			return n;
		});
	},

	/**
	 * reset le store userCurrent
	 */
	resetUserCurrent: (): void => {
		userStore.update((n) => {
			n.userCurrent = {} as IUser;
			return n;
		});
	}
};
