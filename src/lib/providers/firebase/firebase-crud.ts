import { store_notification } from '$lib/modules/notification/store/notification.store';
import { addDoc, collection } from 'firebase/firestore';
import { fire_db } from './firebase.service';
import {} from '$lib/modules/notification/notification.const';

export function fcrud() {
  return {
    add: async function (
      collectionBase: string,
      data: any,
      pathCollection?: string
    ): Promise<void> {
      try {
        await addDoc(collection(fire_db, collectionBase, pathCollection), { ...data });
        store_notification.addNewNotificationUser(
          constEnumNotificationType.SUCCESS,
          constNotificationConfirmation.CREATE_ADVERTISING
        );
      } catch (error) {
        console.error(error);
      }
    },
    update: async function (): void {},
    delete: async function (): void {}
  };
}
