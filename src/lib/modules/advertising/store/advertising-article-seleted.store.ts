import { fcrud, MessageNotif } from '$lib/providers/firebase/firebase-crud';
import { doc, onSnapshot } from 'firebase/firestore';
import type { Unsubscribe } from 'firebase/auth';
import { writable } from 'svelte/store';
import type { IAdvertingArticle } from '../advertising.type';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import { EAdvertisingArticleSelectedContentNotif } from '../advertising.const';


function createStoreAdvertisingArticleSelected() {
  const { set, subscribe, update } = writable({} as IAdvertingArticle);

  let listen_advertising_article_selected: Unsubscribe;
  return {
    set,
    subscribe,
    update,
    listen_advertising_article_selected,

    /**
     * ecouteur de la publicité selectionné
     */
    listenAdvertisingSelected: function (idAdvertising: string, idAdvertisingArticle: string): void {
      // ecouter
      listen_advertising_article_selected = onSnapshot(
        doc(fire_db, 'advertisings', `${idAdvertising}/articles/${idAdvertisingArticle}`),
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
      idAdvertisingArticle: string,
      data: IAdvertingArticle
    ): Promise<void> {
      fcrud(
        'advertisings',
        new MessageNotif(
          EAdvertisingArticleSelectedContentNotif.UPDATE_SUCCES,
          EAdvertisingArticleSelectedContentNotif.UPDATE_ERROR
        ).get()
      ).update(data, `${idAdvertisingselected}/articles/${idAdvertisingArticle}`)
    },

    /**
     * stop l'ecouteur de publicité selected
     */
    stopListenConditionGenSelected: function (): void {
      if (listen_advertising_article_selected) {
        listen_advertising_article_selected();
      }
    },

    /**
     * reset store publicité selected
     */
    resetConditionGenSelected: function (): void {
      set({} as IAdvertingArticle);
    }
  }
}


// store advertising selected
export const advertising_article_selected_store = createStoreAdvertisingArticleSelected();