import { notificationStore } from './notification.store';

export const notificationMutation = {
	/**
	 * ajout nouvelle Notification
	 */
	addNewNotification: (value: string): void => {
		notificationStore.update((n) => {
			// si l'erreur existe deja on l'enleve
			n.notifications = n.notifications.filter((el) => el !== value);
			n.notifications = [...n.notifications, value];
			return n;
		});
	},

	/**
	 * supprime une Notification
	 */
	removeNotification: (value: string): void => {
		notificationStore.update((n) => {
			n.notifications = n.notifications.filter((el) => el !== value);
			return n;
		});
	},

	/**
	 * set le store Notification
	 */
	setNotification: (value: string[]): void => {
		notificationStore.update((n) => {
			n.notifications = value;
			return n;
		});
	}
};
