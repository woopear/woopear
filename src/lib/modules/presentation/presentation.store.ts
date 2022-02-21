import { fire_app, fire_db } from '$lib/providers/firebase/firebase.service';
import {
  addDoc,
  collection,
  deleteDoc,
  doc,
  getDocs,
  onSnapshot,
  query,
  type Unsubscribe
} from 'firebase/firestore';
import { writable } from 'svelte/store';
import type { IPresentation, IPresentationContent } from './presentation.type';

export const presentation_selected_store = writable({} as IPresentation);

const createPresentationStore = () => {
  const { set, update, subscribe } = writable([] as IPresentation[]);

  return {
    set,
    update,
    subscribe,

    async deleteContentPresentation(idPresentation: string, idContent: string): Promise<void> {
      const refDoc = doc(fire_db, 'presentations', `${idPresentation}/contents/${idContent}`);
      await deleteDoc(refDoc);
      await this.getPresentation();
    },

    async createContentPresentation(idPresentation: string): Promise<void> {
      const objContent: IPresentationContent = {
        sub_title: '',
        text: ''
      };

      await addDoc(collection(fire_db, 'presentations', `${idPresentation}/contents`), objContent);
      await this.getPresentation();
    },

    /**
     * fonction qui recupere tous les présentations + leur content
     */
    async getPresentation(): Promise<void> {
      // init des variable global
      let presentation: IPresentation[] = [];
      let content: IPresentationContent[] = [];

      // query pour recupere la collection presentation
      const presentation_query = query(collection(fire_db, 'presentations'));
      // request pour les presentation
      const presentation_snap = await getDocs(presentation_query);
      // on recupere les presentation et on les parcour pour creer l'objet presentation
      presentation_snap.forEach(async (doc) => {
        // creation de l'objet presentation
        let presentation_obj: IPresentation = { id: doc.id, ...doc.data() };

        // nouvelle query sur la collection contents contenue dans les documents
        const content_query = query(collection(fire_db, 'presentations', `${doc.id}/contents`));
        // nouvelle request pour recuperer tout les contents de la présentation en cours
        const content_snap = await getDocs(content_query);
        // on parcours les documents contents pour creer l'objet contents
        content_snap.forEach((doc) => {
          // creation de l'objet contents
          const content_obj: IPresentationContent = { id: doc.id, ...doc.data() };
          // on l'ajout au tableau
          content = [...content, content_obj];
          // on l'ajoute à la présentation en cours
        });

        presentation_obj = { contents: content, ...presentation_obj };
        presentation = [...presentation, presentation_obj];
        set(presentation);
        console.log(presentation);
      });
    }
  };
};

export const presentation_store = createPresentationStore();
