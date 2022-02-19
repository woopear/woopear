import {
  fire_db,
  fire_storage,
  ref_storage_avatar
} from '$lib/providers/firebase/firebase.service';
import {
  collection,
  doc,
  onSnapshot,
  query,
  setDoc,
  updateDoc,
  where,
  type Unsubscribe
} from 'firebase/firestore';
import { getDownloadURL, ref, uploadBytes } from 'firebase/storage';
import { writable } from 'svelte/store';
import type { IUser } from './user.type';

/**
 * creation du writable current user
 * @returns return writable
 */
const createCurrentUserStore = () => {
  const { set, subscribe, update } = writable({} as IUser);

  // pour ecouter le document du user connecter
  let lisen_get_user: Unsubscribe;

  return {
    subscribe,
    set,
    update,

    /**
     * ecoute le document dans la collection users du document de l'utilisateur connecté
     * @param uid => id de l'utilisateur connecté
     */
    getUser: (uid: string): void => {
      const q = query(collection(fire_db, 'users'), where('uid', '==', `${uid}`));
      lisen_get_user = onSnapshot(q, (querySnapshot) => {
        let user: IUser;
        querySnapshot.forEach((doc) => {
          user = { id: doc.id, ...doc.data({ serverTimestamps: 'estimate' }) };
        });
        console.log(user);

        set(user);
      });
    },

    /**
     * arrete l'ecoute de getUser
     */
    stopLisenGetUser: (): void => {
      lisen_get_user();
    },

    /**
     * modifier le document dans la collection users du document de l'utilisateur connecté
     * @param uid => id de l'utilisateur connecté
     */
    async updateUser(id: string, data: IUser): Promise<void> {
      await updateDoc(doc(fire_db, 'users', `${id}`), { ...data });
    },

    /**
     * telechargement de l'image avatar du user connecté
     * upload dans bucket + stockage de l'url dans la proprieter avatar du user
     */
    async uploadAvatarUser(file: Blob | Uint8Array | ArrayBuffer, id: string) {
      // ciblage ou/et creation du nom de fichier
      const i = ref(fire_storage, `avatars/user-avatar-${id}`);
      // enregistrement de l'image dans le dossier avatar
      await uploadBytes(i, file);
      // creation de l'url pour stocker dans le document user
      const url_avatar = await getDownloadURL(i);
      // enregistrement du path de l'image dans le user
      await this.updateUser(id, { avatar: url_avatar });
    }
  };
};

// store du current user
export const current_user_store = createCurrentUserStore();
