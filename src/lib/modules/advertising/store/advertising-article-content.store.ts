import { fcrud, MessageNotif } from '$lib/providers/firebase/firebase-crud';
import { onSnapshot, collection } from 'firebase/firestore';
import { writable } from 'svelte/store';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import type { Unsubscribe } from 'firebase/auth';
import type { IAdvertingArticleContent } from '../advertising.type';
import { createContentAdvertisingArticleObject, EAdvertisingArticleSelectedContentNotif } from '../advertising.const';


// creation store advertising
function createStoreAdvertisingArticleContent() {
  const { subscribe, set, update } = writable([] as IAdvertingArticleContent[]);

  let listen_advertising_article_content: Unsubscribe;

  return {
    subscribe,
    set,
    update,

    /**
     * ecouteur du contents de la Article publicité selectionnée
     * @param idAdvertising id de la publicité selectionnée
     * @param idAdvertisingArticle id de la publicité Article selectionnée
     */
     listenAdvertisingArticleContent: function (
      idAdvertising: string,
      idAdvertisingArticle: string
    ): void {
      listen_advertising_article_content = onSnapshot(
        collection(
          fire_db,
          'advertisings',
          `${idAdvertising}/articles/${idAdvertisingArticle}/contents`
        ),
        (snapShot) => {
          let advertising_article_content: IAdvertingArticleContent[] = [];
          snapShot.forEach((doc) => {
            const obj_advertising_gen_article_content = { id: doc.id, ...doc.data() };
            advertising_article_content = [
              ...advertising_article_content,
              obj_advertising_gen_article_content
            ];
          });
          set(advertising_article_content);
        }
      );
    },

    /**
     * ajouter un content d'article de la publicité selectionné
     * @param idAdvertising id de la publicité selectionnée
     * @param idAdvertisingArticle id de la publicité Article selectionnée
     */
    addContentAdvertisingArticleSelected: async function (
      idAdvertising: string,
      idAdvertisingArticle: string
    ): Promise<void> {
      
      fcrud(
        'advertisings',
        new MessageNotif(
          EAdvertisingArticleSelectedContentNotif.ADD_SUCCES,
          EAdvertisingArticleSelectedContentNotif.ADD_ERROR
        ).get()
      ).add(createContentAdvertisingArticleObject(), `${idAdvertising}/articles/${idAdvertisingArticle}/contents`);
    },

    /**
     * modifier un content d'article de la publicité selectionné
     * @param idAdvertising id de la publicité selectionnée
     * @param idAdvertisingArticle id de la publicité Article selectionnée
     */
    updateContentAdvertisingArticleSelected: async function (
      idAdvertising: string,
      idAdvertisingArticle: string
    ): Promise<void> {
      // sub
      let allContent: IAdvertingArticleContent[];
      subscribe((v) => (allContent = v));

      // modification
      allContent.map(async (el) => {
        let data = {
          text: el.text,
          sub_title: el.sub_title
        }
        await fcrud(
          'advertisings',
        new MessageNotif(
          EAdvertisingArticleSelectedContentNotif.UPDATE_SUCCES,
          EAdvertisingArticleSelectedContentNotif.UPDATE_ERROR
        ).get()
        ).update(
          data,
          `${idAdvertising}/articles/${idAdvertisingArticle}/contents/${el.id}`
        )
      })
    },

    /**
     * fonction qui supprime un article selectionné
     * @param idAdvertising id de la publicité selectionnée
     * @param idAdvertisingArticle id de la publicité Article selectionnée
     * @param idAdvertisingArticleContent id du content de l'article de la publicité selectionné
     */
     deleteContentArticleAdvertisingSelected: async function (
      idAdvertising: string,
      idAdvertisingArticle: string,
      idAdvertisingArticleContent: string,
    ): Promise<void> {
      // suppretion des content de l'article selectionné
      fcrud(
        'advertisings',
        new MessageNotif(
          EAdvertisingArticleSelectedContentNotif.DELETE_SUCCES,
          EAdvertisingArticleSelectedContentNotif.DELETE_ERROR
        ).get()
      ).delete(`${idAdvertising}/articles/${idAdvertisingArticle}/contents/${idAdvertisingArticleContent}`);
    },

    /**
     * supprimer tous les article de la publicité
     * @param idAdvertising id de la publicité selectionnée
     */
    deleteAllContentArticleAdvertisingSelected: async function (idAdvertising: string): Promise<void> {
      let allArticlesContent: IAdvertingArticleContent[];
      subscribe((v) => (allArticlesContent = v));

      // map pour delete chaque article
      allArticlesContent.map(async (el) => {
        await this.deleteArticleAdvertisingSelected(el.id, idAdvertising);
      });
    },

    /**
     * stop l'ecouteur de la publicité
     */
     stopListenAdvertisingArticle: function (): void {
      if (listen_advertising_article_content) {
        listen_advertising_article_content();
      }
    },

    /**
     * reset store de la publicité
     */
    resetAdvertising: function (): void {
      set([] as IAdvertingArticleContent[]);
    }
  }
}

export const advertising_article_content_store = createStoreAdvertisingArticleContent();