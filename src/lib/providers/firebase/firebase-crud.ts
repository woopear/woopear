import { store_notification } from '$lib/modules/notification/store/notification.store';
import { addDoc, collection } from 'firebase/firestore';
import { fire_db } from './firebase.service';
import {
  constEnumNotificationType,
  ENotificationError,
  type TAllOfNotification
} from '$lib/modules/notification/notification.const';

export function fcrud() {
  return {
    /**
     * ajoute document dans collection
     * @param collectionBase nom de la collection de base
     * @param data les données pour creation, doit correspondre à votre model
     * @param messageError le message notification partie catch de type "constNotificationError"
     * @param message le message notification partie try de type "TAllOfNotification" optionnel si pas de message pas de notif
     * @param pathCollection le path pour atteindre une collection enfant d'un document optionnel
     */
    add: async function (
      collectionBase: string,
      data: any,
      messageError: ENotificationError,
      message?: TAllOfNotification,
      pathCollection?: string
    ): Promise<void> {
      try {
        // ajoute document dans collection avec ou sans pathCollection
        pathCollection
          ? await addDoc(collection(fire_db, collectionBase, pathCollection), { ...data })
          : await addDoc(collection(fire_db, collectionBase), { ...data });

        // si message alors notification
        message
          ? store_notification.addNewNotificationUser(constEnumNotificationType.SUCCESS, message)
          : null;
      } catch (error) {
        // error pour interface
        store_notification.addNewNotificationUser(constEnumNotificationType.ERROR, messageError);
        // error pour dev
        throw new Error(error);
      }
    }
    //update: async function (): void {},
    //delete: async function (): void {}
  };
}
