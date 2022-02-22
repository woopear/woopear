import { fire_db, fire_storage } from '$lib/providers/firebase/firebase.service';
import { addDoc, collection, deleteDoc, doc, getDocs, query, updateDoc } from 'firebase/firestore';
import { deleteObject, getDownloadURL, ref, uploadBytes } from 'firebase/storage';
import { writable } from 'svelte/store';
import type { IPresentation, IPresentationContent } from './presentation.type';

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
    addContent(content: IPresentationContent): void {
      update((n) => {
        n.contents = [...n.contents, content];
        return n;
      });
    },

    /**
     * supprime un content sur la presentation selected
     * @param idContent id du content à supprimer
     */
    deleteContent(idContent: string): void {
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

const createPresentationStore = () => {
  const { set, update, subscribe } = writable([] as IPresentation[]);

  return {
    set,
    update,
    subscribe,

    /**
     * fonction qui recupere tous les présentations + leur content
     */
    getPresentation: async function (): Promise<void> {
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

        // creation de l'objet presentation avec les contents
        presentation_obj = { contents: content, ...presentation_obj };
        //ajout des contents + des proprieter racine
        presentation = [...presentation, presentation_obj];
        // on set le store
        set(presentation);
      });
    },

    /**
     * fonction qui supprime un content à la présentation selectionné
     * @param idPresentation id de la présentation en cours de modification
     * @param idContent id du content qu'on veux supprimer
     */
    deleteContentPresentation: async function (
      idPresentation: string,
      idContent: string
    ): Promise<void> {
      // suppression
      await deleteDoc(doc(fire_db, 'presentations', `${idPresentation}/contents/${idContent}`));

      // on recupere les nouvelles données
      await this.getPresentation();

      // suppression dans le store presentation selected
      presentation_selected_store.deleteContent(idContent);
    },

    /**
     * ajoute et creer un content d'un présentation
     * @param idPresentation id de la presentation
     */
    createContentPresentation: async function (idPresentation: string): Promise<void> {
      // creation de l'objet content
      const objContent: IPresentationContent = {
        sub_title: '',
        text: ''
      };

      // creation du document avec l'objet creer ci-dessus
      const newDoc: IPresentationContent = await addDoc(
        collection(fire_db, 'presentations', `${idPresentation}/contents`),
        objContent
      );

      // on recupere les nouvelles données
      await this.getPresentation();

      // on ajout le nouveau content au store de presentation selected
      presentation_selected_store.addContent({
        sub_title: newDoc.sub_title,
        id: newDoc.id,
        text: newDoc.text
      });
    },

    /**
     * fonction qui modifie les données racine d'une presentation selectionné
     * @param idPresentation id de la presentation ciblé
     * @param data les données à modifier
     */
    updatePresentation: async function (
      idPresentation: string,
      data: IPresentation
    ): Promise<void> {
      // modification des données à la racine
      await updateDoc(doc(fire_db, 'presentations', `${idPresentation}`), {
        ...data
      });

      // on recupere les nouvelles données
      await this.getPresentation();

      // on update le store
      update((n) => {
        n = { ...n, ...data };
        return n;
      });
    },

    /**
     * modification des contents de la présentation selectionné
     * @param idPresentation id de la presentation selectionné
     */
    updateContentOfPresentation: async function (idPresentation: string): Promise<void> {
      // boucle sur les contents
      let p: IPresentation;
      presentation_selected_store.subscribe((v) => (p = v));
      p.contents.forEach(async (el) => {
        // avec l'id on cible et on modifie les données
        await updateDoc(doc(fire_db, 'presentations', `${idPresentation}/contents/${el.id}`), {
          sub_title: el.sub_title,
          text: el.text
        });
      });

      // on recupere les nouvelles données
      await this.getPresentation();
    },

    /**
     * fonction qui upload un fichier pour la présentation selectionnée
     * @param file => fichier à upload
     * @param idPresentation => id de la presentation selectionnée
     */
    uploadImagePresentation: async function (file, idPresentation: string): Promise<void> {
      // ciblage ou/et creation du nom de fichier
      const i = ref(fire_storage, `articles/presentation-${idPresentation}`);
      // enregistrement de l'image dans le dossier avatar
      await uploadBytes(i, file);
      // creation de l'url pour stocker dans le document user
      const url_img = await getDownloadURL(i);

      // on modifie la presentation
      await this.updatePresentation(idPresentation, { image: url_img });

      // on modifie la presentation selectionné
      presentation_selected_store.update((n) => {
        n.image = url_img;
        return n;
      });
    },

    /**
     * fonction qui supprime l'image de la presentation selectionné
     * @param idPresentation => id de la presentation ciblé
     */
    deleteImagePresentation: async function (idPresentation): Promise<void> {
      // suppression de l'image
      await deleteObject(ref(fire_storage, `articles/presentation-${idPresentation}`));

      // on modifie la presentation
      await this.updatePresentation(idPresentation, { image: '' });

      // on modifie la presentation selectionné
      presentation_selected_store.update((n) => {
        n.image = '';
        return n;
      });
    },

    /**
     * reset le store des presentations
     */
    resetPresentation: function (): void {
      set([] as IPresentation[]);
    }
  };
};

// store presentation
export const presentation_store = createPresentationStore();

// creation du store presentation active
const createPresentationActiveStore = () => {
  const { set, update, subscribe } = writable({} as IPresentation);

  return {
    set,
    update,
    subscribe
  };
};

// store presentation active
export const presentation_active_store = createPresentationActiveStore();
