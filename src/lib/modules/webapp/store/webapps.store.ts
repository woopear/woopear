import { fcrud, MessageNotif } from '$lib/providers/firebase/firebase-crud';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import { collection, onSnapshot, type Unsubscribe } from 'firebase/firestore';
import { writable } from 'svelte/store';
import { createWebapp, EWebappNotif } from '../webapp.const';
import type { IWebapp } from '../webapp.type';
import { webapp_product_store } from './webapp-products.store';

function createStoreWebapps() {
  const { set, subscribe, update } = writable([] as IWebapp[]);

  // ecouteur
  let listen_webapps: Unsubscribe;

  // sub
  function sub(): IWebapp[] {
    let s: IWebapp[];
    subscribe((v) => (s = v));
    return s;
  }

  return {
    set,
    subscribe,
    update,

    /**
     * ecouteur des web app
     */
    listenWebapps: function (): void {
      listen_webapps = onSnapshot(collection(fire_db, 'webapp'), (snapShot) => {
        let web_app: IWebapp[] = [];
        snapShot.forEach((doc) => {
          const obj_web_app = { id: doc.id, ...doc.data() };
          web_app = [...web_app, obj_web_app];
        });
        set(web_app);
      });
    },

    /**
     * ajout d'un webapp
     */
    addWebApp: async function (): Promise<void> {
      await fcrud(
        'webapp',
        new MessageNotif(EWebappNotif.ADD_SUCCES, EWebappNotif.ADD_ERROR).get()
      ).add(createWebapp());
    },

    /**
     * modification de la webapp
     * @param data donnée pour modifié
     * @param idWebapp id de la web app à modifier
     */
    updateWebapp: async function (data: IWebapp, idWebapp: string): Promise<void> {
      await fcrud(
        'webapp',
        new MessageNotif(EWebappNotif.UPDATE_SUCCES, EWebappNotif.UPDATE_ERROR).get()
      ).update(data, `${idWebapp}`);
    },

    /**
     * suppression d'un web app
     * @param idWebapp id de la
     */
    deleteWebapp: async function (idWebapp: string): Promise<void> {
      // on supprime les product si il y en a
      const products = await webapp_product_store.getWebappProduct(idWebapp);
      if (products.length > 0) {
        products.forEach(async (el) => {
          await webapp_product_store.deleteWebappProduct(el.id, idWebapp);
        });
      }

      // on recupere le webapp concerné
      const webapps: IWebapp[] = sub();
      const webapp = webapps.find((el) => el.id === idWebapp);

      // si image supprime image, sinon supprime simple
      webapp.image !== ''
        ? await fcrud(
            'webapp',
            new MessageNotif(EWebappNotif.DELETE_SUCCES, EWebappNotif.DELETE_ERROR).get()
          ).delete(`${idWebapp}`, `articles/webapp-${webapp.id}`)
        : await fcrud(
            'webapp',
            new MessageNotif(EWebappNotif.DELETE_SUCCES, EWebappNotif.DELETE_ERROR).get()
          ).delete(`${idWebapp}`);
    },

    /**
     * stop ecouteur
     */
    stopListen: function (): void {
      if (listen_webapps) {
        listen_webapps();
      }
    },

    /**
     * reset le store
     */
    reset: function (): void {
      set([] as IWebapp[]);
    }
  };
}

// store web app
export const webapps_store = createStoreWebapps();
