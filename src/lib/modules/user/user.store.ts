import { fire_db } from '$lib/providers/firebase/firebase.service';
import { collection, onSnapshot, query, where } from 'firebase/firestore';
import { writable } from 'svelte/store';
import type { IUser } from './user.type';

/**
 * creation du writable current user
 * @returns return writable
 */
const createCurrentUserStore = () => {
  const { set, subscribe, update } = writable({} as IUser);

  let lisen_get_user;

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
    }
  };
};

// store du current user
export const current_user_store = createCurrentUserStore();
