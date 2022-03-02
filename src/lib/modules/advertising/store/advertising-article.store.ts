import { fcrud, MessageNotif } from '$lib/providers/firebase/firebase-crud';
import { onSnapshot, collection, doc } from 'firebase/firestore';
import type { IAdvertingArticle } from './../advertising.type';
import { writable } from 'svelte/store';
import type { Unsubscribe } from 'firebase/auth';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import { createAdvertisingArticleObject, EAdvertisingArticleSelectedNotif } from '../advertising.const';


function createStoreAdvertisingArticle() {
  const { subscribe, set, update } = writable([] as IAdvertingArticle[])

  let listen_advertising_article: Unsubscribe;

  return {
    subscribe,
    set,
    update,
    /** 
     * ecouter les article de la publicité selectionné
     * @param idAdvertising id de la publicité selectionné
     */
    listenAdvertisingSelectedArticle: function (idAdvertising: string): void {
      listen_advertising_article = onSnapshot(
        collection(fire_db, 'advertisings', `${idAdvertising}/articles`),
        (snapShot) => {
          let advertising_articles: IAdvertingArticle[] = [];
          snapShot.forEach((doc) => {
            const obj_advertising_article = { id: doc.id, ...doc.data() };
            advertising_articles = [...advertising_articles, obj_advertising_article];
          });
          set(advertising_articles);
        }
      );
    },
    
    /**
     * ajout d'un article a la publicité selectionné
     * @param idAdvertisingSelected id de la publicité selectionné
     */
    addArticleAdvertisingSelected: async function (idAdvertisingSelected: string): Promise<void> {
      fcrud(
        'advertisings',
        new MessageNotif(
          EAdvertisingArticleSelectedNotif.ADD_SUCCES,
          EAdvertisingArticleSelectedNotif.ADD_ERROR
        ).get()
      ).add(createAdvertisingArticleObject(),`${idAdvertisingSelected}/articles`);
    },

    /**
     * fonction qui upload une image pour la publicité selected
     * @param file fichier à telecharger
     * @param idAdvertising id de la publicité selected
     * @param idAdvertisingArticle id de l'article de publicité selected
     */
     uploadImageAdvertisingArticleSelected: async function (file, idAdvertising: string, idAdvertisingArticle:string): Promise<void> {
      await fcrud(
        'advertisings',
        new MessageNotif(
          EAdvertisingArticleSelectedNotif.UPLOAD_IMAGE_SUCCES,
          EAdvertisingArticleSelectedNotif.UPLOAD_IMAGE_ERROR
        ).get()
      ).uploadImage(
        `articles/advertising-article-${idAdvertising}`, 
        `${idAdvertising}/articles/${idAdvertisingArticle}`, 
        file
      );
    },


    /**
     * suppression de l'image publicité selected
     * @param idAdvertising id de la publicité selected
     * @param idAdvertisingArticle id de l'article de publicité selected
     */
     deleteImageAdvertisingArticleSelected: async function (idAdvertising: string, idAdvertisingArticle:string): Promise<void> {
      await fcrud(
        'advertisings',
        new MessageNotif(
          `${EAdvertisingArticleSelectedNotif.DELIMAGE_SUCCES}`,
          `${EAdvertisingArticleSelectedNotif.DELIMAGE_ERROR} N° ${idAdvertising}`
        ).get()
      ).deleteImage(`articles/advertising-article-${idAdvertising}`, `${idAdvertising}/articles/${idAdvertisingArticle}`, { image: '' });
    },

    /**
     * fonction qui supprime un article selectionné
     */
    deleteArticleAdvertisingSelected: async function (
      idAdvertising: string,
      idAdvertisingArticle: string
    ): Promise<void> {
      // suppretion des content de l'article selectionné
      fcrud(
        'advertisings',
        new MessageNotif(
          EAdvertisingArticleSelectedNotif.DELETE_SUCCES,
          EAdvertisingArticleSelectedNotif.DELETE_ERROR
        ).get()
      ).delete(`${idAdvertising}/articles/${idAdvertisingArticle}`);
    },

    /**
     * supprimer tous les article de la publicité
     */
    deleteAllArticleAdvertisingSelected: async function (idAdvertising: string): Promise<void> {
      let allArticles: IAdvertingArticle[];
      subscribe((v) => (allArticles = v));

      // map pour delete chaque article
      allArticles.map(async (el) => {
        await this.deleteArticleAdvertisingSelected(el.id, idAdvertising);
      });
    },

    /**
     * stop l'ecouteur de la publicité
     */
     stopListenAdvertisingArticle: function (): void {
      if (listen_advertising_article) {
        listen_advertising_article();
      }
    },

    /**
     * reset store de la publicité
     */
    resetAdvertising: function (): void {
      set([] as IAdvertingArticle[]);
    }
  }
}

export const advertising_article_store = createStoreAdvertisingArticle();