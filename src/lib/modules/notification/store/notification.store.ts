import type { INotification } from './../notification.type';

import { writable } from 'svelte/store';
import { query, collection } from 'firebase/firestore';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import { current_user_store } from '$lib/modules/user/user.store';


/* 
* writable notification
*/
const createNotificationStore = () => {
  const { set, update, subscribe } = writable([] as INotification[])

  return {
    set,
    update,
    subscribe,

    /* 
    * 
    */
    async listenNotification(uid: string): Promise<void> {
      let notifications: INotification[] = [];

      // query pour récupèrer la collection notification sur firebase
      const notification_query = query(collection(fire_db, 'notifications', `uid: ${uid}`))
      
      
    }
  }
}
export const store_notification  = createNotificationStore();