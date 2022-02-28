import { constNotificationConfirmation, constNotificationError } from './../../notification/notification.const';
import { store_notification } from './../../notification/store/notification.store';
import { onSnapshot, collection, addDoc, deleteDoc, doc, updateDoc } from 'firebase/firestore';
import type { IAdverting } from './../advertising.type';
import { writable } from 'svelte/store';
import type { Unsubscribe } from 'firebase/auth';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import { constEnumNotificationType } from '$lib/modules/notification/notification.const';

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
      try {
        const obj_advertising: IAdverting = {
          active: false,
          image: '',
          label: {
            description: '',
            libelle: ''
          },
          title:''
        }
        await addDoc(collection(fire_db, 'advertisings'), obj_advertising);
        store_notification.addNewNotificationUser(
          constEnumNotificationType.SUCCESS, 
          constNotificationConfirmation.CREATE_ADVERTISING
        );
      } catch (error) {
        store_notification.addNewNotificationUser(
          constEnumNotificationType.ERROR,
          constNotificationError.CREATE_ADVERTISING
        );
        throw new error(store_notification.addNewNotificationUser(
          constEnumNotificationType.ERROR,
          constNotificationError.CREATE_ADVERTISING
        ));
      }
    },

    /**
     * supprimer la publicité
     */
    deleteAdvertising: async function (idAdvertising: string): Promise<void> {
      try {
        // supprimer
        await deleteDoc(doc(fire_db, 'advertisings', `${idAdvertising}`));
        store_notification.addNewNotificationUser(
          constEnumNotificationType.SUCCESS,
          constNotificationConfirmation.DELETE_ADVERTISING,
        )
      } catch (error) {
        store_notification.addNewNotificationUser(
          constEnumNotificationType.ERROR,
          constNotificationError.DELETE_ADVERTISING,
        );
        throw new error(store_notification.addNewNotificationUser(
          constEnumNotificationType.ERROR,
          constNotificationError.DELETE_ADVERTISING,
        ))
      }
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
      try {
        // modification
        await updateDoc(doc(fire_db, 'advertisings', `${idAdvertising}`), { ...data});
      } catch (error) {
        
      }
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