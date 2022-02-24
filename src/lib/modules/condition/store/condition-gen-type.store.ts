import { fire_db } from '$lib/providers/firebase/firebase.service';
import {
  addDoc,
  collection,
  deleteDoc,
  doc,
  onSnapshot,
  type Unsubscribe
} from 'firebase/firestore';
import { writable } from 'svelte/store';
import type { ICondition, IConditionGeneral } from '../condition.type';
import { condition_gen_type_content_store } from './condition-gen-type-content.store';
import { condition_gen_type_selected_store } from './condition-gen-type-selected.store';

// creation store condition gen
function createStoreConditionGenType() {
  const { subscribe, set, update } = writable([] as ICondition[]);

  let listen_condition_gen_type: Unsubscribe;

  return {
    subscribe,
    set,
    update,

    /**
     * ecoute les articles de la condition gen selectionné
     * @param idConditionGenSelected id de la condition gen selectionné
     */
    listenConditionGenSelectedType: function (idConditionGenSelected: string): void {
      listen_condition_gen_type = onSnapshot(
        collection(fire_db, 'conditions_generales', `${idConditionGenSelected}/conditions`),
        (snapShot) => {
          let condition_gen_type: ICondition[] = [];
          snapShot.forEach((doc) => {
            const obj_condition_gen_type = { id: doc.id, ...doc.data() };
            condition_gen_type = [...condition_gen_type, obj_condition_gen_type];
          });
          set(condition_gen_type);
        }
      );
    },

    /**
     * ajout d'un type de condition à la condition selected
     * @param idConditionGenSelected id de la condition selected
     */
    addTypeConditionGenSelected: async function (idConditionGenSelected: string): Promise<void> {
      try {
        // creation de l'objet type condition
        const obj_article_condition_gen_selected: ICondition = {
          title: '',
          sub_title: '',
          type: ''
        };
        // ajoute
        await addDoc(
          collection(fire_db, 'conditions_generales', `${idConditionGenSelected}/conditions`),
          obj_article_condition_gen_selected
        );
      } catch (error) {
        // TODO : gestion erreur
        console.error(error);
      }
    },

    /**
     * fonction qui supprime une type condition
     * @param idCondition id de la type condition à supprimer
     * @param idConditionGenSelected id de la condition gen relier
     */
    deleteTypeConditionGenSelected: async function (
      idCondition: string,
      idConditionGenSelected: string
    ): Promise<void> {
      try {
        // suppression des content de la condition gen type selectionné
        await condition_gen_type_content_store.deleteAllContentConditionGenTypeSelected(
          idConditionGenSelected,
          idCondition
        );

        // suppression
        await deleteDoc(
          doc(
            fire_db,
            'conditions_generales',
            `${idConditionGenSelected}/conditions/${idCondition}`
          )
        );
      } catch (error) {
        // TODO : gestion erreur
        console.error(error);
      }
    },

    /**
     * supprime tous les types de condition relier à la condition gen parent
     * @param idConditionGen id de la condition gen parent
     */
    deleteAllTypeConditionGen: async function (idConditionGen: string): Promise<void> {
      try {
        let tc: ICondition[];
        subscribe((v) => (tc = v));

        // delete chaque condition gen type
        tc.map(async (el) => {
          await this.deleteTypeConditionGenSelected(el.id, idConditionGen);
        });
      } catch (error) {
        // TODO : gestion erreur
        console.error(error);
      }
    },

    /**
     * stop l'ecouteur de condition gen
     */
    stopListenArticleConditionGenSelected: function (): void {
      if (listen_condition_gen_type) {
        listen_condition_gen_type();
      }
    },

    /**
     * reset store condition gen
     */
    resetArticleConditionGenSelected: function (): void {
      set([] as ICondition[]);
    }
  };
}

// store condition gen
export const condition_gen_type_store = createStoreConditionGenType();
