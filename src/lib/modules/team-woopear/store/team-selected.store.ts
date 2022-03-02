import { fcrud, MessageNotif } from '$lib/providers/firebase/firebase-crud';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import { doc, onSnapshot, type Unsubscribe } from 'firebase/firestore';
import { writable } from 'svelte/store';
import { ETeamSelectedNotif } from '../team-woopear.const';
import type { ITeam } from '../team-woopear.type';

function createStoreTeamSelected() {
  const { set, update, subscribe } = writable({} as ITeam);

  // ecouteur teamselected
  let listen_team_selected: Unsubscribe;

  return {
    set,
    subscribe,
    update,

    /**
     * ecouteur de la team selectionné
     * @param idTeamSelected id de la team selectionné
     */
    listenTeamSelected: function (idTeamSelected: string): void {
      listen_team_selected = onSnapshot(doc(fire_db, 'team', `${idTeamSelected}`), (snapShot) => {
        const obj_team_selected = { id: snapShot.id, ...snapShot.data() };
        set(obj_team_selected);
      });
    },

    /**
     * fonction qui modifie la team selectionné
     * @param data les données de modification
     * @param idTeamSelected id de la team selectionné
     */
    updateTeamSelected: async function (data: ITeam, idTeamSelected: string): Promise<void> {
      await fcrud(
        'team',
        new MessageNotif(ETeamSelectedNotif.UPDATE_SUCCES, ETeamSelectedNotif.UPDATE_ERROR).get()
      ).update(data, `${idTeamSelected}`);
    },

    /**
     * stop ecouteur listen team selected
     */
    stopListenTeamSelected: function (): void {
      if (listen_team_selected) {
        listen_team_selected();
      }
    },

    /**
     * reset store
     */
    reset: function (): void {
      set({} as ITeam);
    }
  };
}

export const team_seletect_store = createStoreTeamSelected();
