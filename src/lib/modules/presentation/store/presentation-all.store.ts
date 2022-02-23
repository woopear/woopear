import { presentation_selected_store } from '../presentation.store';
import type { IWoopear } from '$lib/modules/woopear/woopear.type';
import { fire_db, fire_storage } from '$lib/providers/firebase/firebase.service';
import { addDoc, collection, deleteDoc, doc, getDocs, query, updateDoc } from 'firebase/firestore';
import { deleteObject, getDownloadURL, ref, uploadBytes } from 'firebase/storage';
import { writable } from 'svelte/store';
import type { IPresentation, IPresentationContent } from '../presentation.type';

// creation du store all presentation
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

      let count = 0;
      presentation_snap.forEach(async (doc) => {
        count++;

        // creation de l'objet presentation
        let presentation_obj: IPresentation = { id: doc.id, ...doc.data() };

        // nouvelle request pour recuperer tout les contents de la présentation en cours
        const content_snap = await getDocs(
          collection(fire_db, 'presentations', `${doc.id}/contents`)
        );

        // si pas de document content
        content_snap.size === 0 ? (presentation_obj = { contents: [], ...presentation_obj }) : null;

        let count2 = 0;
        // on parcours les documents contents pour creer l'objet contents
        content_snap.forEach((doc2) => {
          count2++;
          // creation de l'objet contents
          const content_obj: IPresentationContent = { id: doc2.id, ...doc2.data() };
          // on l'ajout au tableau
          content = [...content, content_obj];
          // creation de l'objet presentation avec les contents
          if (count2 === content_snap.size) {
            presentation_obj = { contents: [...content], ...presentation_obj };
            content = [];
          }
        });

        //ajout des contents + des proprieter racine
        presentation = [...presentation, presentation_obj];

        // on set le store quand c'est finis
        if (count === presentation_snap.size) set(presentation);
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
    deleteImagePresentation: async function (idPresentation: string): Promise<void> {
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
     * ajout presentation
     */
    addPresentation: async function (): Promise<void> {
      // creation des objets contenu dans la collection
      const obj_woopear: IWoopear = {
        address: '',
        city: '',
        code_post: '',
        email: '',
        info: '',
        map: '',
        name: '',
        phone_number: ''
      };
      const obj_presentation: IPresentation = {
        active: false,
        image: '',
        sub_title: '',
        title: '',
        woopear: { ...obj_woopear }
      };

      // creation du document dans la collection presentation
      await addDoc(collection(fire_db, 'presentations'), obj_presentation);

      // on recupere les nouvelle données
      await this.getPresentation();
    },

    /**
     * suppression de tous les documents de la collection "contents" du document "presentation"
     * @param idPresentation id de la presentation
     */
    deleteCollectionContents: async function (idPresentation): Promise<void> {
      // nouvelle query sur la collection contents contenue dans les documents
      const content_query = query(
        collection(fire_db, 'presentations', `${idPresentation}/contents`)
      );
      // nouvelle request pour recuperer tout les contents de la présentation en cours
      const content_snap = await getDocs(content_query);
      // on parcours les documents contents pour creer l'objet contents
      content_snap.forEach(async (document) => {
        await deleteDoc(doc(fire_db, 'presentations', `${idPresentation}/contents/${document.id}`));
      });
    },

    /**
     * suppression du document presentation
     * @param idPresentation id de la presentation
     */
    deletePresentation: async function (idPresentation: string): Promise<void> {
      let p: IPresentation[];
      subscribe((v) => (p = v));
      // delete des documents de la collection "contents" du document de la collection "presentation"
      await this.deleteCollectionContents(idPresentation);

      // si image associé on delete l'image également
      p.map(async (el) => {
        if (el.id === idPresentation) {
          if (el.image !== '') {
            // suppression de l'image
            await deleteObject(ref(fire_storage, `articles/presentation-${idPresentation}`));
          }
        }
      });

      // delete le document de la collection "presentation"
      await deleteDoc(doc(fire_db, 'presentations', `${idPresentation}`));
      // on re recupere toute les données de la collection "presentations"
      await this.getPresentation();
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
