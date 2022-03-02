import { fcrud, MessageNotif } from '$lib/providers/firebase/firebase-crud';
import { constNotificationConfirmation, constNotificationError } from './../../notification/notification.const';
import { store_notification } from './../../notification/store/notification.store';
import { onSnapshot, collection, addDoc, deleteDoc, doc, updateDoc } from 'firebase/firestore';
import type { IAdverting } from './../advertising.type';
import { writable } from 'svelte/store';
import type { Unsubscribe } from 'firebase/auth';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import { constEnumNotificationType } from '$lib/modules/notification/notification.const';
import { createAdvertisingObject, EAdvertisingNotif } from '../advertising.const';
import { advertising_article_store } from './advertising-article.store';

// création du store advertising
function createStoreAdvertising() {
  const { set, update, subscribe } = writable([] as IAdverting[]);

  // ecouteur de advertising
  let listen_advertising: Unsubscribe;

  return {
    subscribe,
    set,
    update,
    listen_advertising,

    /* 
     *ecoute de advertising
     */
    listenAdvertising: function (): void {
      // ecouteur
      listen_advertising = onSnapshot(collection(fire_db, 'advertisings'), (snapShot) => {
        let advertisings: IAdverting[] = [];
        // on parcours les documents
        snapShot.forEach((doc) => {
          // creation du document
          const obj_advertising = { id: doc.id, ...doc.data()};
          // ajout dans le tableau de advertising
          advertisings = [...advertisings, obj_advertising];
        });
        // on set le store
        set(advertisings);
      });
    },

    /* 
     * ajouter une advertising
     */
    addAdvertissing: async function () {
        await fcrud('advertisings', new MessageNotif(
          EAdvertisingNotif.ADD_SUCCES, 
          EAdvertisingNotif.ADD_ERROR
        ).get()).add(createAdvertisingObject()); 
        
    },

    /**
     * supprimer la publicité
     */
    deleteAdvertising: async function (idAdvertising: string): Promise<void> {
      // delete le article de la publicité
      await advertising_article_store.deleteAllArticleAdvertisingSelected(idAdvertising);

      // delete la publicité selectionné
      await fcrud('advertisings', new MessageNotif(
        EAdvertisingNotif.DELETE_SUCCES,
        EAdvertisingNotif.DELETE_ERROR
      ).get()).delete(`${idAdvertising}`);
    },

    /**
     * modification de la publicité selectionné
     * @param idAdvertising => id de la condition ciblé
     * @param data => les données pour modification
     */
    updateAdvertisingSelected: async function (
      idAdvertising: string,
      data: IAdverting,
    ): Promise<void> {
      await fcrud('advertisings', new MessageNotif(
        EAdvertisingNotif.UPDATE_SUCCES,
        EAdvertisingNotif.UPDATE_ERROR
      ).get()).update(data, `${idAdvertising}`)
    },

    /**
     * stop l'ecouteur de la publicité
     */
     stopListenAdvertising: function (): void {
      if (listen_advertising) {
        listen_advertising();
      }
    },

    /**
     * reset store de la publicité
     */
    resetAdvertising: function (): void {
      set([] as IAdverting[]);
    }
  }
}

export const advertising_store = createStoreAdvertising();