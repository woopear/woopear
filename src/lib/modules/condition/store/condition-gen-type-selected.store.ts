import { fire_db } from '$lib/providers/firebase/firebase.service';
import { doc, onSnapshot, updateDoc, type Unsubscribe } from 'firebase/firestore';
import { writable } from 'svelte/store';
import type { ICondition } from '../condition.type';

function createStoreConditionGenTypeSelected() {
  const { subscribe, set, update } = writable({} as ICondition);

  let listen_condition_gen_type_selected: Unsubscribe;

  return {
    subscribe,
    set,
    update,

    /**
     * ecouteur d'une type condition selectionné
     * @param idConditionType id type condition
     * @param idConditionGenSelected id de la condition gen selected
     */
    listenConditionGenTypeSelected: function (
      idConditionType: string,
      idConditionGenSelected: string
    ): void {
      listen_condition_gen_type_selected = onSnapshot(
        doc(
          fire_db,
          'conditions_generales',
          `${idConditionGenSelected}/conditions/${idConditionType}`
        ),
        (snapShot) => {
          set({ id: snapShot.id, ...snapShot.data() });
        }
      );
    },

    /**
     * modifie condition type selectionné
     * @param data les données pour modifier
     * @param idConditionTypeSelected id de la condition type selectionné
     * @param idConditionGenSelected id de ka condition gen selectionné
     */
    updateConditionGenTypeSelected: async function (
      data: ICondition,
      idConditionTypeSelected: string,
      idConditionGenSelected: string
    ): Promise<void> {
      try {
        // modification
        await updateDoc(
          doc(
            fire_db,
            'conditions_generales',
            `${idConditionGenSelected}/conditions/${idConditionTypeSelected}`
          ),
          { ...data }
        );
      } catch (error) {
        // TODO : gestion erreur
        console.error(error);
      }
    },

    /**
     * stop l'ecouteur de condition gen type selected
     */
    stopListenConditionGenTypeSelected: function (): void {
      if (listen_condition_gen_type_selected) {
        listen_condition_gen_type_selected();
      }
    },

    /**
     * reset store condition gen type selected
     */
    resetConditionGenTypeSelected: function (): void {
      set({} as ICondition);
    }
  };
}

// store type condition selectionné
export const condition_gen_type_selected_store = createStoreConditionGenTypeSelected();
