import { fcrud, MessageNotif } from '$lib/providers/firebase/firebase-crud';
import { doc, onSnapshot } from 'firebase/firestore';
import type { IAdverting } from './../advertising.type';
import { writable } from 'svelte/store';
import type { Unsubscribe } from 'firebase/auth';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import { EAdvertisingSelectedNotif } from '../advertising.const';


function createStoreAdvertisingSelected() {
  const { set, subscribe, update } = writable({} as IAdverting);

  let listen_advertising_selected: Unsubscribe;
  return {
    set,
    subscribe,
    update,
    listen_advertising_selected,

    /**
     * ecouteur de la publicité selectionné
     */
    listenAdvertisingSelected: function (idAdvertising: string): void {
      // ecouter
      listen_advertising_selected = onSnapshot(
        doc(fire_db, 'advertisings', `${idAdvertising}`),
        (doc) => {
          // set store
          set({ id: doc.id, ...doc.data() });
        }
      );
    },

    /**
     * modifier la publicté selectionné
     */
    updateAdvertisingSelected: async function (
      idAdvertisingselected: string,
      data: IAdverting
    ): Promise<void> {
      fcrud(
        'advertisings',
        new MessageNotif(
          EAdvertisingSelectedNotif.UPDATE_SUCCES,
          EAdvertisingSelectedNotif.UPDATE_ERROR
        ).get()
      ).update(data, `${idAdvertisingselected}`)
    },

    /**
     * stop l'ecouteur de publicité selected
     */
    stopListenConditionGenSelected: function (): void {
      if (listen_advertising_selected) {
        listen_advertising_selected();
      }
    },

    /**
     * reset store publicité selected
     */
    resetConditionGenSelected: function (): void {
      set({} as IAdverting);
    }
  }
}


// store advertising selected
export const advertising_selected_store = createStoreAdvertisingSelected();