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
        collection(fire_db, 'advertising', `${idAdvertising}/articles`),
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
     */
    addArticleAdvertisingSelected: async function (idAdvertisingSelected: string): Promise<void> {
      fcrud(
        'advertising',
        new MessageNotif(
          EAdvertisingArticleSelectedNotif.ADD_SUCCES,
          EAdvertisingArticleSelectedNotif.ADD_ERROR
        ).get()
      ).add(createAdvertisingArticleObject(),`${idAdvertisingSelected}/articles`);
    }
  }
}

export const advertising_article_store = createStoreAdvertisingArticle();