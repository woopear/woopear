import { fire_db, fire_storage } from '$lib/providers/firebase/firebase.service';
import {
  addDoc,
  arrayRemove,
  arrayUnion,
  collection,
  deleteDoc,
  doc,
  onSnapshot,
  updateDoc,
  type Unsubscribe
} from 'firebase/firestore';
import { deleteObject, getDownloadURL, ref, uploadBytes } from 'firebase/storage';
import { writable } from 'svelte/store';
import type { IProduct } from '../webapp.type';

function createStoreWebappProductStore() {
  const { set, subscribe, update } = writable([] as IProduct[]);
  let listen_web_app_product: Unsubscribe;
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
     * ajoute un product
     * @param idWebAppSelected id de webapp selected
     */
    addNewWebappProduct: async function (idWebAppSelected): Promise<void> {
      try {
        const obj_product: IProduct = {
          content: '',
          title: '',
          url: '',
          images: [],
          technos: []
        };
        await addDoc(collection(fire_db, 'webapp', `${idWebAppSelected}/products`), obj_product);
      } catch (error) {
        // TODO : gestion error
        console.log(error);
      }
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
      try {
        const technos = [...data.technos];
        delete data.technos;

        // modification donnée simple
        await updateDoc(doc(fire_db, 'webapp', `${idWebappSelected}/products/${idWebappProduct}`), {
          ...data
        });

        // modification du tableau technos
        if (technos.length > 0) {
          technos.forEach(async (el) => {
            await updateDoc(
              doc(fire_db, 'webapp', `${idWebappSelected}/products/${idWebappProduct}`),
              {
                technos: arrayUnion(el)
              }
            );
          });
        }
      } catch (error) {
        // TODO : gestion error
        console.log(error);
      }
    },

    deleteWebappProduct: async function (
      idWebappProduct: string,
      idWebappSelected: string
    ): Promise<void> {
      try {
        // suppression des images
        //sub au tab de product
        let wap: IProduct[];
        subscribe((v) => (wap = v));
        // recuperation du product ciblé
        const webapp_product = wap.find((el) => el.id === idWebappProduct);
        // si il y a des images on les supprimes
        if (webapp_product.images.length > 0) {
          webapp_product.images.forEach(async (el, i) => {
            await this.deleteImageWebappProduct(el, idWebappSelected, idWebappProduct, i);
          });
        }

        // delete produc
        await deleteDoc(doc(fire_db, 'webapp', `${idWebappSelected}/products/${idWebappProduct}`));
      } catch (error) {
        // TODO : gestion error
        console.log(error);
      }
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
      try {
        //sub au tab de product
        let wap: IProduct[];
        subscribe((v) => (wap = v));
        // recuperation du product ciblé
        const webapp_product = wap.find((el) => el.id === idWebappSelectedProduct);
        // recuperation de la longeur du tableau image pour construire le nom de l'image
        const position_img = webapp_product.images.length;
        // ciblage ou/et creation du nom de fichier
        const i = ref(
          fire_storage,
          `articles/webappproduct-${idWebappSelectedProduct}-${position_img}`
        );

        // enregistrement de l'image dans le dossier articles
        await uploadBytes(i, file);
        // creation de l'url pour stocker dans le document webapp product
        const url_img = await getDownloadURL(i);
        // ajout de l'url dans le tableau image du document webapp product ciblé
        await updateDoc(
          doc(fire_db, 'webapp', `${idWebappSelect}/products/${idWebappSelectedProduct}`),
          {
            images: arrayUnion(url_img)
          }
        );
      } catch (error) {
        // TODO : gestion error
        console.log(error);
      }
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
      idWebappProduct: string,
      index
    ): Promise<void> {
      try {
        // suppression de l'image
        await deleteObject(ref(fire_storage, `articles/webappproduct-${idWebappProduct}-${index}`));
        // suppression de l'url dans le tableau image de product
        await updateDoc(doc(fire_db, 'webapp', `${idWebappSelect}/products/${idWebappProduct}`), {
          images: arrayRemove(urlForDelete)
        });
      } catch (error) {
        // TODO : gestion error
        console.log(error);
      }
    }
  };
}

// store product webapp
export const webapp_product_store = createStoreWebappProductStore();
