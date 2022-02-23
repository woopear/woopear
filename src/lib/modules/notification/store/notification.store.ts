import type { INotification } from './../notification.type';

import { writable } from 'svelte/store';
import { query, collection, where, onSnapshot, QuerySnapshot } from 'firebase/firestore';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import { current_user_store } from '$lib/modules/user/user.store';
import type { Unsubscribe } from 'firebase/auth';


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

    /* 
    * 
    */
    async listenNotificationUser(uid: string): Promise<void> {
      let notifications: INotification[] = [];
      
      // query pour récupèrer la collection notification sur firebase
      const notification_query = query(collection(fire_db, 'notifications'), where ('uid', '==', `${uid}`));
      lisen_get_notification = onSnapshot(notification_query, (QuerySnapshot)=> {
        let notification:INotification;
        QuerySnapshot.forEach((doc) => {
          notification = { id: doc.id, ...doc.data() }
          notifications =[...notifications, notification]
          set(notifications);
        })
      })

    }
  }
}
export const store_notification  = createNotificationStore();