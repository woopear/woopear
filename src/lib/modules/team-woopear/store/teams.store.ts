import { fcrud, MessageNotif } from '$lib/providers/firebase/firebase-crud';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import { collection, onSnapshot, type Unsubscribe } from 'firebase/firestore';
import { writable } from 'svelte/store';
import { createTeam, ETeamNotif } from '../team-woopear.const';
import type { ITeam } from '../team-woopear.type';
import { team_producers_store } from './producers.store';

function createStoreTeams() {
  const { set, subscribe, update } = writable([] as ITeam[]);

  // ecouteur
  let listen_teams: Unsubscribe;

  return {
    set,
    subscribe,
    update,

    /**
     * ecoute de team
     */
    listenTeams: function (): void {
      listen_teams = onSnapshot(collection(fire_db, 'team'), (snapShot) => {
        let teams: ITeam[] = [];
        snapShot.forEach((doc) => {
          const obj_team = { id: doc.id, ...doc.data() };
          teams = [...teams, obj_team];
        });
        set(teams);
      });
    },

    /**
     * creation d'une équipe
     */
    addTeam: async function (): Promise<void> {
      await fcrud('team', new MessageNotif(ETeamNotif.ADD_SUCCES, ETeamNotif.ADD_ERROR).get()).add(
        createTeam()
      );
    },

    /**
     * fonction qui modifie la team ciblé
     * @param data les données pour modification
     * @param idTeam id de la team à modifier
     */
    updateTeam: async function (data: ITeam, idTeam: string): Promise<void> {
      await fcrud(
        'team',
        new MessageNotif(ETeamNotif.UPDATE_SUCCES, ETeamNotif.UPDATE_ERROR).get()
      ).update(data, `${idTeam}`);
    },

    /**
     * supprime une team
     * @param idTeam id de la team ciblé
     */
    deleteTeam: async function (idTeam: string): Promise<void> {
      // si il y a des producers on les supprimes
      const producers = await team_producers_store.getTeamProducer(idTeam);
      if (producers.length > 0) {
        producers.forEach(async (el) => {
          await team_producers_store.deleteTeamProducer(idTeam, el.id);
        });
      }

      // delete le document team
      await fcrud(
        'team',
        new MessageNotif(ETeamNotif.DELETE_SUCCES, ETeamNotif.DELETE_ERROR).get()
      ).delete(`${idTeam}`);
    },

    /**
     * stop ecouteur
     */
    stopListenTeam: function (): void {
      if (listen_teams) {
        listen_teams();
      }
    },

    /**
     * remise à zero du store
     */
    reset: function (): void {
      set([] as ITeam[]);
    }
  };
}

// store teams
export const teams_store = createStoreTeams();
