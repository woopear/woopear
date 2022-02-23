import { fire_db } from '$lib/providers/firebase/firebase.service';
import {
  addDoc,
  collection,
  deleteDoc,
  doc,
  onSnapshot,
  updateDoc,
  type Unsubscribe
} from 'firebase/firestore';
import { writable } from 'svelte/store';
import type { IConditionGeneral } from '../condition.type';
import { condition_gen_selected_store } from './condition-gen-selected.store';

// creation store condition gen
function createStoreConditionGen() {
  const { subscribe, set, update } = writable([] as IConditionGeneral[]);

  // ecouteur de condition gen
  let listen_condition_gen: Unsubscribe;

  return {
    subscribe,
    set,
    update,
    listen_condition_gen,

    /**
     * ecouter de conditions generales
     */
    listenConditionGen: function (): void {
      // ecouteur
      listen_condition_gen = onSnapshot(collection(fire_db, 'conditions_generales'), (snapShot) => {
        let condition_gen: IConditionGeneral[] = [];
        // on parcours les documents
        snapShot.forEach((doc) => {
          // creation du document
          const obj_condition_gen = { id: doc.id, ...doc.data() };
          // ajout du document au tableau
          condition_gen = [...condition_gen, obj_condition_gen];
        });
        // on set le store
        set(condition_gen);
      });
    },

    /**
     * ajoute une condition general
     */
    addConditionGen: async function (): Promise<void> {
      try {
        const obj_condition_gen: IConditionGeneral = {
          active: false,
          title: ''
        };

        // ajoute
        await addDoc(collection(fire_db, 'conditions_generales'), obj_condition_gen);
      } catch (error) {
        // TODO : gestion erreur
        console.error(error);
      }
    },

    /**
     * supprime la condition gen
     * @param idCondition id de la condition gen à supprimer
     */
    deleteConditionGen: async function (idCondition: string): Promise<void> {
      try {
        // TODO : ajouter la suppression des collections du document

        // supprime
        await deleteDoc(doc(fire_db, 'conditions_generales', `${idCondition}`));

        // stop ecouteur + reset condition gen selected store
        condition_gen_selected_store.stopListenConditionGenSelected();
        condition_gen_selected_store.resetConditionGenSelected();
      } catch (error) {
        // TODO : gestion erreur
        console.error(error);
      }
    },

    /**
     * modifie un document condition general
     * @param idCondition => id de la condition ciblé
     * @param data => les données pour modification
     */
    updateConditionGen: async function (
      idCondition: string,
      data: IConditionGeneral
    ): Promise<void> {
      try {
        // update
        await updateDoc(doc(fire_db, 'conditions_generales', `${idCondition}`), { ...data });
      } catch (error) {
        // TODO : gestion erreur
        console.error(error);
      }
    },

    /**
     * stop l'ecouteur de condition gen
     */
    stopListenConditionGen: function (): void {
      listen_condition_gen();
    },

    /**
     * reset store condition gen
     */
    resetConditionGen: function (): void {
      set([] as IConditionGeneral[]);
    }
  };
}

// store condition gen
export const condition_gen_store = createStoreConditionGen();
