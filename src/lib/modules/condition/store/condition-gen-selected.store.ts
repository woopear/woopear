import { fire_db } from '$lib/providers/firebase/firebase.service';
import { doc, onSnapshot, type Unsubscribe } from 'firebase/firestore';
import { writable } from 'svelte/store';
import type { IConditionGeneral } from '../condition.type';

// creation du store condition gen selected
function createStoreConditionGenSelected() {
  const { set, subscribe, update } = writable({} as IConditionGeneral);

  let listen_condition_gen_selected: Unsubscribe;
  return {
    set,
    subscribe,
    update,
    listen_condition_gen_selected,

    /**
     * ecouteur de la condition selectionné
     * @param idCondition id de la condition à écouter
     */
    listenConditionGenSelected: function (idCondition: string): void {
      //ecoute
      listen_condition_gen_selected = onSnapshot(
        doc(fire_db, 'conditions_generales', `${idCondition}`),
        (doc) => {
          // set store
          set({ id: doc.id, ...doc.data() });
        }
      );
    },

    /**
     * stop l'ecouteur de condition gen
     */
    stopListenConditionGenSelected: function (): void {
      listen_condition_gen_selected();
    },

    /**
     * reset store condition gen
     */
    resetConditionGenSelected: function (): void {
      set({} as IConditionGeneral);
    }
  };
}

// store condition gen selected
export const condition_gen_selected_store = createStoreConditionGenSelected();
