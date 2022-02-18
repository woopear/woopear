import { fire_db } from '$lib/providers/firebase/firebase.service';
import { collection, doc, onSnapshot, query, setDoc, updateDoc, where, type Unsubscribe } from 'firebase/firestore';
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
    getUser: (uid: string) => {
      const q = query(collection(fire_db, 'users'), where('uid', '==', `${uid}`));
      lisen_get_user = onSnapshot(q, (querySnapshot) => {
        let user: IUser;
        querySnapshot.forEach((doc) => {
          user = doc.data();
        });

        set(user);
      });
    },

    /**
     * arrete l'ecoute de getUser
     */
    stopLisenGetUser: () => {
      lisen_get_user();
    },

    /* 
    * modifier le document dans la collection users du document de l'utilisateur connecté
    * @param uid => id de l'utilisateur connecté
    */
    updateUser: async (uid: string, data: IUser): Promise<void> => {
      await updateDoc(doc(fire_db,'users',`alvPtU1VZgfzPh0KgRPO`),{data});
     
    } 
  };
};

// store du current user
export const current_user_store = createCurrentUserStore();
