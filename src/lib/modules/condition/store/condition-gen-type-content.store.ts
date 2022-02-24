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
import type { IConditionContent } from '../condition.type';

// creation store condition gen
function createStoreConditionGenTypeContent() {
  const { subscribe, set, update } = writable([] as IConditionContent[]);

  let listen_condition_gen_type_content: Unsubscribe;

  return {
    subscribe,
    set,
    update,

    /**
     * ecouteur du contents de la type condition selectionnée
     * @param idConditionGen id de la condition gen selectionnée
     * @param idConditionGenType id de la condition gen type selectionnée
     */
    listenConditionGenTypeContent: function (
      idConditionGen: string,
      idConditionGenType: string
    ): void {
      listen_condition_gen_type_content = onSnapshot(
        collection(
          fire_db,
          'conditions_generales',
          `${idConditionGen}/conditions/${idConditionGenType}/contents`
        ),
        (snapShot) => {
          let condition_gen_type_content: IConditionContent[] = [];
          snapShot.forEach((doc) => {
            const obj_condition_gen_type_content = { id: doc.id, ...doc.data() };
            condition_gen_type_content = [
              ...condition_gen_type_content,
              obj_condition_gen_type_content
            ];
          });
          set(condition_gen_type_content);
        }
      );
    },

    /**
     * ajoute un contents à la condition gen type selectionné
     * @param idConditionGen id de la condition gen selectionné
     * @param idConditionGenType id de la condition gen type selectionné
     */
    addContentConditionGenTypeSelected: async function (
      idConditionGen: string,
      idConditionGenType: string
    ): Promise<void> {
      try {
        // creation objet content
        const obj_content_condition_gen_type: IConditionContent = {
          content: ''
        };
        // ajout du document contents à type condition selected
        await addDoc(
          collection(
            fire_db,
            'conditions_generales',
            `${idConditionGen}/conditions/${idConditionGenType}/contents`
          ),
          obj_content_condition_gen_type
        );
      } catch (error) {
        // TODO : gestion erreur
        console.error(error);
      }
    },

    /**
     * fonction qui modifie les contents de la condition gen type selected
     * @param idConditionGenSelected id de la condition gen selected
     * @param idConditionGenTypeSelected id de la condition gen type selected
     */
    updateContentConditionGenTypeSelected: async function (
      idConditionGenSelected: string,
      idConditionGenTypeSelected: string
    ): Promise<void> {
      try {
        // sub
        let c: IConditionContent[];
        subscribe((v) => (c = v));

        // modification
        c.map(async (el) => {
          await updateDoc(
            doc(
              fire_db,
              'conditions_generales',
              `${idConditionGenSelected}/conditions/${idConditionGenTypeSelected}/contents/${el.id}`
            ),
            { content: el.content }
          );
        });
      } catch (error) {
        // TODO : gestion erreur
        console.error(error);
      }
    },

    /**
     * fonction qui supprime un content de la condition gen type selectionné
     * @param idConditionGenSelected id de la condition gen selectionné
     * @param idConditionGenTypeSelected id de la condition gen type selectionné
     * @param idConditionGenTypeContent id de la condition gen type content selectionné
     */
    deleteContentConditionGenTypeSelected: async function (
      idConditionGenSelected: string,
      idConditionGenTypeSelected: string,
      idConditionGenTypeContent: string
    ): Promise<void> {
      try {
        // suppression
        await deleteDoc(
          doc(
            fire_db,
            'conditions_generales',
            `${idConditionGenSelected}/conditions/${idConditionGenTypeSelected}/contents/${idConditionGenTypeContent}`
          )
        );
      } catch (error) {
        // TODO : gestion erreur
        console.error(error);
      }
    },

    /**
     * fonction qui supprime tous les contents d'un condition gen type selectionné
     * @param idConditionGenSelected id condition gen selectionné
     * @param idConditionGenTypeSelected id de la condition gen type selected
     */
    deleteAllContentConditionGenTypeSelected: async function (
      idConditionGenSelected: string,
      idConditionGenTypeSelected: string
    ): Promise<void> {
      try {
        // sub
        let c: IConditionContent[];
        subscribe((v) => (c = v));

        // delete
        c.map(async (el) => {
          console.log('content', el);

          await this.deleteContentConditionGenTypeSelected(
            idConditionGenSelected,
            idConditionGenTypeSelected,
            el.id
          );
        });
      } catch (error) {
        // TODO : gestion erreur
        console.error(error);
      }
    },

    /**
     * stop l'ecouteur de condition gen
     */
    stopListenArticleConditionGenTypeContent: function (): void {
      if (listen_condition_gen_type_content) {
        listen_condition_gen_type_content();
      }
    },

    /**
     * reset store condition gen
     */
    resetArticleConditionGenTypeContent: function (): void {
      set([] as IConditionContent[]);
    }
  };
}

// store condition gen
export const condition_gen_type_content_store = createStoreConditionGenTypeContent();
