import { fcrud, MessageNotif } from '$lib/providers/firebase/firebase-crud';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import { doc, onSnapshot, type Unsubscribe } from 'firebase/firestore';
import { writable } from 'svelte/store';
import { EWebappSelectedNotif } from '../webapp.const';
import type { IWebapp } from '../webapp.type';

function createStoreWebappSelected() {
  const { set, subscribe, update } = writable({} as IWebapp);

  // ecouteur
  let listen_web_app_selected: Unsubscribe;

  return {
    set,
    subscribe,
    update,

    /**
     * ecouteur sur un web app
     * @param idWebapp id du webapp à écouter
     */
    listenWebappSelected: function (idWebapp: string): void {
      listen_web_app_selected = onSnapshot(doc(fire_db, 'webapp', `${idWebapp}`), (snapShot) => {
        set({ id: snapShot.id, ...snapShot.data() });
      });
    },

    /**
     * modification du webapp selected
     * @param idWebappSelected id de la web app selected
     * @param data les données pour modification
     */
    updateWebappSelected: async function (idWebappSelected: string, data: IWebapp): Promise<void> {
      await fcrud(
        'webapp',
        new MessageNotif(
          `${EWebappSelectedNotif.UPDATE_SUCCES}`,
          `${EWebappSelectedNotif.UPDATE_ERROR} N° ${idWebappSelected}`
        ).get()
      ).update(data, `${idWebappSelected}`);
    },

    /**
     * fonction qui upload une image pour la web app selected
     * @param file fichier à telecharger
     * @param idWebappSelected id de la web app selected
     */
    uploadImageWebappSelected: async function (file, idWebappSelected: string): Promise<void> {
      await fcrud(
        'webapp',
        new MessageNotif(
          EWebappSelectedNotif.UPLOAD_IMAGE_SUCCES,
          EWebappSelectedNotif.UPLOAD_IMAGE_ERROR
        ).get()
      ).uploadImage(`articles/webapp-${idWebappSelected}`, `${idWebappSelected}`, file);
    },

    /**
     * suppression de l'image webapp selected
     * @param idWebappSelected id de la webapp selected
     */
    deleteImageWebappSelected: async function (idWebappSelected: string): Promise<void> {
      await fcrud(
        'webapp',
        new MessageNotif(
          `${EWebappSelectedNotif.DELIMAGE_SUCCES}`,
          `${EWebappSelectedNotif.DELIMAGE_ERROR} N° ${idWebappSelected}`
        ).get()
      ).deleteImage(`articles/webapp-${idWebappSelected}`, `${idWebappSelected}`, { image: '' });
    },

    /**
     * stop ecouteur
     */
    stopListen: function (): void {
      if (listen_web_app_selected) {
        listen_web_app_selected();
      }
    },

    /**
     * reset le store
     */
    reset: function (): void {
      set({} as IWebapp);
    }
  };
}

// store webapp selected
export const webapp_selected_store = createStoreWebappSelected();
