import { onSnapshot, collection, doc, serverTimestamp, addDoc } from 'firebase/firestore';
import type { IAdverting } from './../advertising.type';
import { writable } from 'svelte/store';
import type { Unsubscribe } from 'firebase/auth';
import { fire_db } from '$lib/providers/firebase/firebase.service';

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
        
      } catch (error) {
        
      }
    }
  }
}

export const advertising_store = createStoreAdvertising();