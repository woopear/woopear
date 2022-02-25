import type { IUser } from './../../user/user.type';
import type { INotification } from './../notification.type';

import { writable } from 'svelte/store';
import { query, collection, where, onSnapshot, addDoc, deleteDoc, doc } from 'firebase/firestore';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import type { Unsubscribe } from 'firebase/auth';
import { current_user_store } from '$lib/modules/user/user.store';


/* 
* writable notification
*/
const createNotificationStore = () => {
  const { set, update, subscribe } = writable([] as INotification[])

  // ecouteur du document notification du user connecté
  let lisen_get_notification: Unsubscribe;

  return {
    set,
    update,
    subscribe,

    /**
     * ecoute du document de la collection notification par user
     * @param uid => l'id de l'utilisateur connecté
     */
    listenNotificationUser(uid: string): void {
      // query pour récupèrer la collection notification sur firebase
      const notification_query = query(collection(fire_db, 'notifications'), where ('uid', '==', `${uid}`));
      lisen_get_notification = onSnapshot(notification_query, (QuerySnapshot)=> {
        let notifications: INotification[] = [];
        let notification:INotification;
        QuerySnapshot.forEach((doc) => {
          notification = { id: doc.id, ...doc.data() }
          notifications =[...notifications, notification]
        })
        set(notifications);
      })
    },

    /**
     * arrete de l'ecoute du document dans la collection notification
     */
    stopLisenNotificationUser: (): void => {
      if(lisen_get_notification) {
        lisen_get_notification();
      }
    },

    /**
     * reset le store
     */
    resetNotification: (): void => {
      set([]);
    },

    /**
     * creation d'une notification
     */
    async newNotificationUser(type: string, libelle:string, uid?: string): Promise<void> {
      await addDoc(collection(fire_db, "notifications"), {type: type, libelle: libelle, uid: uid});
    },

    /**
     * ajoute une notification
     */
    async addNewNotificationUser(type: string, libelle: string, uid?: string): Promise<void> {
      let cu: IUser;
      current_user_store.subscribe(v => cu = v)
      await this.newNotificationUser(type, libelle, uid = cu.uid)
    },

    /**
     * supprimer une notification
     */
    async removeNotificationUser(id:string): Promise<void> {
      await deleteDoc(doc(fire_db, "notifications", id));
    }
  }
}
export const store_notification  = createNotificationStore();