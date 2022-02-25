import { fire_db, fire_storage } from '$lib/providers/firebase/firebase.service';
import { doc, onSnapshot, updateDoc, type Unsubscribe } from 'firebase/firestore';
import { deleteObject, getDownloadURL, ref, uploadBytes } from 'firebase/storage';
import { writable } from 'svelte/store';
import type { IWebapp } from '../webapp.type';

function createStoreWebappSelected() {
  const { set, subscribe, update } = writable({} as IWebapp);

  let listen_web_app_selected: Unsubscribe;

  return {
    set,
    subscribe,
    update,

    /**
     * ecouteur sur un web app
     * @param idWebapp id du webapp à écouter
     */
    listenWebappSelected: function (idWebapp): void {
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
      try {
        // modification
        await updateDoc(doc(fire_db, 'webapp', `${idWebappSelected}`), { ...data });
      } catch (error) {
        // TODO : gestion error
        console.log(error);
      }
    },

    /**
     * fonction qui upload une image pour la web app selected
     * @param file fichier à telecharger
     * @param idWebappSelected id de la web app selected
     */
    uploadImageWebappSelected: async function (file, idWebappSelected: string): Promise<void> {
      try {
        // ciblage ou/et creation du nom de fichier
        const i = ref(fire_storage, `articles/webapp-${idWebappSelected}`);
        // enregistrement de l'image dans le dossier articles
        await uploadBytes(i, file);
        // creation de l'url pour stocker dans le document webapp
        const url_img = await getDownloadURL(i);
        // modification du web app selected
        this.updateWebappSelected(idWebappSelected, { image: url_img });
      } catch (error) {
        // TODO : gestion error
        console.log(error);
      }
    },

    /**
     * suppression de l'image webapp selected
     * @param idWebappSelected id de la webapp selected
     */
    deleteImageWebappSelected: async function (idWebappSelected: string): Promise<void> {
      try {
        // suppression de l'image
        await deleteObject(ref(fire_storage, `articles/webapp-${idWebappSelected}`));

        // modification
        this.updateWebappSelected(idWebappSelected, { image: '' });
      } catch (error) {
        // TODO : gestion error
        console.log(error);
      }
    }
  };
}

// store webapp selected
export const webapp_selected_store = createStoreWebappSelected();
