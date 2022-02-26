import {
  ENotificationConfirmation,
  ENotificationError
} from '$lib/modules/notification/notification.const';
import { fcrud } from '$lib/providers/firebase/firebase-crud';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import {
  addDoc,
  collection,
  deleteDoc,
  doc,
  onSnapshot,
  updateDoc,
  type Unsubscribe
} from 'firebase/firestore';
import { writable } from 'svelte/store';
import type { IWebapp } from '../webapp.type';
import { webapp_selected_store } from './webapp-selected.store';

function createStoreWebapps() {
  const { set, subscribe, update } = writable([] as IWebapp[]);

  let listen_webapps: Unsubscribe;

  return {
    set,
    subscribe,
    update,

    createWebapp: function (): IWebapp {
      return {
        active: false,
        description: '',
        image: '',
        title: ''
      };
    },

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
      fcrud().add(
        'webapp',
        this.createWebapp(),
        ENotificationError.CREATE_WEBAPP,
        ENotificationConfirmation.CREATE_WEBAPP
      );
    },

    /**
     * modification de la webapp
     * @param data donnée pour modifié
     * @param idWebapp id de la web app à modifier
     */
    updateWebapp: async function (data: IWebapp, idWebapp: string): Promise<void> {
      try {
        // modification
        await updateDoc(doc(fire_db, 'webapp', `${idWebapp}`), { ...data });
      } catch (error) {
        // TODO : gerer error
        console.log(error);
      }
    },

    /**
     * suppression d'un web app
     * @param idWebapp id de la
     */
    deleteWebapp: async function (idWebapp: string): Promise<void> {
      try {
        // supprission de l'image
        await webapp_selected_store.deleteImageWebappSelected(idWebapp);

        // TODO : delete les collections enfants

        // delete
        await deleteDoc(doc(fire_db, 'webapp', `${idWebapp}`));
      } catch (error) {
        // TODO : gerer error
        console.log(error);
      }
    }
  };
}

// store web app
export const webapps_store = createStoreWebapps();
