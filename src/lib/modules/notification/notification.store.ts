import type { INotification } from './notification.type';
import { writable } from 'svelte/store';


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
  }
}
export const store_notification  = createNotificationStore();