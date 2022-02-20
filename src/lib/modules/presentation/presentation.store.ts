import { fire_db } from '$lib/providers/firebase/firebase.service';
import { collection, doc, getDocs, onSnapshot, query, type Unsubscribe } from 'firebase/firestore';
import { writable } from 'svelte/store';
import type { IPresentation, IPresentationContent } from './presentation.type';

const createPresentationStore = () => {
  const { set, update, subscribe } = writable([] as IPresentation[]);

  return {
    set,
    update,
    subscribe,

    async listenPresentation(): Promise<void> {
      let presentation: IPresentation[] = [];
      let content: IPresentationContent[] = [];

      const presentation_query = query(collection(fire_db, 'presentations'));
      const presentation_snap = await getDocs(presentation_query);
      presentation_snap.forEach(async (doc) => {
        let presentation_obj: IPresentation = { id: doc.id, ...doc.data() };

        const content_query = query(collection(fire_db, 'presentations', `${doc.id}/contents`));
        const content_snap = await getDocs(content_query);
        content_snap.forEach((doc) => {
          const content_obj: IPresentationContent = { id: doc.id, ...doc.data() };
          content = [...content, content_obj];
          presentation_obj = { contents: content, ...presentation_obj };
        });

        presentation = [...presentation, presentation_obj];
        set(presentation);
      });
    }
  };
};

export const presentation_store = createPresentationStore();
