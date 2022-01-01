import { notificationAction } from './stores/notification.action';
import { notificationGetter } from './stores/notification.getter';
import { notificationMutation } from './stores/notification.mutation';

export const notificationService = {
	...notificationGetter,
	...notificationMutation,
	...notificationAction
};
