import { writable } from 'svelte/store';
import type { IPresentation, IPresentationContent } from '../presentation.type';

// creation du store presentation selected
const createPresentationSelectedStore = () => {
  const { subscribe, set, update } = writable({} as IPresentation);

  return {
    subscribe,
    set,
    update,

    /**
     * ajout du nouveau content à la presentation selected
     * @param content nouveau content
     */
    addContent: function (content: IPresentationContent): void {
      update((n) => {
        n.contents = [...n.contents, content];
        return n;
      });
    },

    /**
     * supprime un content sur la presentation selected
     * @param idContent id du content à supprimer
     */
    deleteContent: function (idContent: string): void {
      update((n) => {
        n.contents = n.contents.filter((el) => el.id !== idContent);
        return n;
      });
    },

    /**
     * reset store presentation selected
     */
    resetPresentationSelected: function (): void {
      set({} as IPresentation);
    }
  };
};

// store presentation selected
export const presentation_selected_store = createPresentationSelectedStore();
