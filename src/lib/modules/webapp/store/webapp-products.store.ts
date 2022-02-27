import { fcrud, MessageNotif } from '$lib/providers/firebase/firebase-crud';
import { v4 as uuidv4 } from 'uuid';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import {
  arrayRemove,
  collection,
  getDocs,
  onSnapshot,
  query,
  type Unsubscribe
} from 'firebase/firestore';
import { writable } from 'svelte/store';
import { createWebappProduct, EWebappProductNotif } from '../webapp.const';
import type { IProduct } from '../webapp.type';

function createStoreWebappProductStore() {
  const { set, subscribe, update } = writable([] as IProduct[]);

  // ecouteur
  let listen_web_app_product: Unsubscribe;

  // sub
  function sub(): IProduct[] {
    let s: IProduct[];
    subscribe((v) => (s = v));
    return s;
  }

  return {
    set,
    subscribe,
    update,

    /**
     * ecouteur sur un web app
     * @param idWebapp id du webapp à écouter
     */
    listenWebappProducts: function (idWebappSelect: string): void {
      listen_web_app_product = onSnapshot(
        collection(fire_db, 'webapp', `${idWebappSelect}/products`),
        (snapShot) => {
          let web_app_products: IProduct[] = [];
          snapShot.forEach((doc) => {
            const obj_web_app_product = { id: doc.id, ...doc.data() };
            web_app_products = [...web_app_products, obj_web_app_product];
          });
          set(web_app_products);
        }
      );
    },

    /**
     * retourne le tableau de products du web app ciblé
     * @param idWebapp id du web app ciblé
     * @returns retourne le tableau de products
     */
    getWebappProduct: async function (idWebapp: string): Promise<IProduct[]> {
      const products = await getDocs(query(collection(fire_db, 'webapp', `${idWebapp}/products`)));
      return products.docs;
    },

    /**
     * ajoute un product
     * @param idWebAppSelected id de webapp selected
     */
    addNewWebappProduct: async function (idWebAppSelected: string): Promise<void> {
      await fcrud(
        'webapp',
        new MessageNotif(EWebappProductNotif.ADD_SUCCES, EWebappProductNotif.ADD_ERROR).get()
      ).add(createWebappProduct(), `${idWebAppSelected}/products`);
    },

    /**
     * modification des données de product
     * @param data les donnée pour modification
     * @param idWebappProduct id web app product
     * @param idWebappSelected id webapp selected
     */
    updateWebappProduct: async function (
      data: IProduct,
      idWebappProduct: string,
      idWebappSelected: string
    ): Promise<void> {
      await fcrud(
        'webapp',
        new MessageNotif(EWebappProductNotif.UPDATE_SUCCES, EWebappProductNotif.UPDATE_ERROR).get()
      ).update(data, `${idWebappSelected}/products/${idWebappProduct}`);
    },

    /**
     * suppression du product + image du product si il y en a
     * @param idWebappProduct id du product
     * @param idWebappSelected id du webapp selected
     */
    deleteWebappProduct: async function (
      idWebappProduct: string,
      idWebappSelected: string
    ): Promise<void> {
      //recupere le products ciblé
      const wap: IProduct[] = sub();
      const webapp_product = wap.find((el) => el.id === idWebappProduct);
      // si il y a des images on les supprimes
      if (webapp_product.images.length > 0) {
        webapp_product.images.forEach(async (el, i) => {
          // on recupere le nom de l'image
          const name_of_file = el.substring(el.indexOf('_'), el.indexOf('?'));
          await fcrud('webapp', new MessageNotif('', '').get()).deleteImage(
            `articles/webappproduct${name_of_file}`
          );
        });
      }
      // delete produc
      await fcrud(
        'webapp',
        new MessageNotif(EWebappProductNotif.DELETE_SUCCES, EWebappProductNotif.DELETE_ERROR).get()
      ).delete(`${idWebappSelected}/products/${idWebappProduct}`);
    },

    /**
     * fonction qui ajoute une image au product
     * @param file fichier
     * @param idWebappSelect id du web app selected
     * @param idWebappSelectedProduct id du product ciblé
     */
    uploadImageWebappProduct: async function (
      file,
      idWebappSelect: string,
      idWebappSelectedProduct: string
    ): Promise<void> {
      await fcrud('webapp', new MessageNotif('', '').get()).uploadImage(
        `articles/webappproduct_${idWebappSelectedProduct}_${uuidv4()}`,
        `${idWebappSelect}/products/${idWebappSelectedProduct}`,
        file,
        false
      );
    },

    /**
     * suppression d'une des images du product
     * @param urlForDelete url de l'image ciblé
     * @param idWebappSelect id du webapp selectionné
     * @param idWebappProduct id du product
     * @param index l'index de l'url dans le product
     */
    deleteImageWebappProduct: async function (
      urlForDelete: string,
      idWebappSelect: string,
      idWebappProduct: string
    ): Promise<void> {
      // on recupere le nom de l'image dans l'url
      const name_of_file = urlForDelete.substring(
        urlForDelete.indexOf('_'),
        urlForDelete.indexOf('?')
      );
      // on supprime l'images
      await fcrud('webapp', new MessageNotif('', '').get()).deleteImage(
        `articles/webappproduct${name_of_file}`,
        `${idWebappSelect}/products/${idWebappProduct}`,
        {
          images: arrayRemove(urlForDelete)
        }
      );
    },

    /**
     * stop ecouteur
     */
    stopListen: function (): void {
      if (listen_web_app_product) {
        listen_web_app_product();
      }
    },

    /**
     * reset le store
     */
    reset: function (): void {
      set([] as IProduct[]);
    }
  };
}

// store product webapp
export const webapp_product_store = createStoreWebappProductStore();
