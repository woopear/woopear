import { fcrud, MessageNotif } from '$lib/providers/firebase/firebase-crud';
import { doc, onSnapshot } from 'firebase/firestore';
import type { IAdverting } from './../advertising.type';
import { writable } from 'svelte/store';
import type { Unsubscribe } from 'firebase/auth';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import { EAdvertisingNotif } from '../advertising.const';


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
          EAdvertisingNotif.UPDATE_SUCCES,
          EAdvertisingNotif.UPDATE_ERROR
        ).get()
      ).update(data, `${idAdvertisingselected}`)
    },

    /**
     * fonction qui upload une image pour la publicité selected
     * @param file fichier à telecharger
     * @param idAdvertising id de la publicité selected
     */
     uploadImageAdvertisingSelected: async function (file, idAdvertising: string): Promise<void> {
      await fcrud(
        'advertisings',
        new MessageNotif(
          EAdvertisingNotif.UPLOAD_IMAGE_SUCCES,
          EAdvertisingNotif.UPLOAD_IMAGE_ERROR
        ).get()
      ).uploadImage(`articles/advertising-${idAdvertising}`, `${idAdvertising}`, file);
    },


    /**
     * suppression de l'image publicité selected
     * @param idAdvertising id de la publicité selected
     */
     deleteImageAdvertisingSelected: async function (idAdvertising: string): Promise<void> {
      await fcrud(
        'advertisings',
        new MessageNotif(
          `${EAdvertisingNotif.DELIMAGE_SUCCES}`,
          `${EAdvertisingNotif.DELIMAGE_ERROR} N° ${idAdvertising}`
        ).get()
      ).deleteImage(`articles/advertising-${idAdvertising}`, `${idAdvertising}`, { image: '' });
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