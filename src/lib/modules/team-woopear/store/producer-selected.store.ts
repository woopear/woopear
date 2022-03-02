import { fcrud, MessageNotif } from '$lib/providers/firebase/firebase-crud';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import { doc, onSnapshot, type Unsubscribe } from 'firebase/firestore';
import { writable } from 'svelte/store';
import { ETeamSelectedProducerNotif } from '../team-woopear.const';
import type { ITeamProducer } from '../team-woopear.type';

function createStoreTeamProducerSelected() {
  const { set, subscribe, update } = writable({} as ITeamProducer);

  // ecouteur producer selected
  let listen_team_producer_selected: Unsubscribe;

  return {
    set,
    subscribe,
    update,

    /**
     * ecouteur du producer selectionné
     * @param idTeamSelected id de la team selectionné
     * @param idTeamProducerSelected id du producer selectionné
     */
    listenTeamProducerSelected: function (
      idTeamSelected: string,
      idTeamProducerSelected: string
    ): void {
      listen_team_producer_selected = onSnapshot(
        doc(fire_db, 'team', `${idTeamSelected}/producers/${idTeamProducerSelected}`),
        (snapShot) => {
          set({ id: snapShot.id, ...snapShot.data() });
        }
      );
    },

    /**
     * fonction qui modifie le product selectionné
     * @param data les donnée pour modification
     * @param idTeamSelected id du team selectionné
     * @param idTeamProductSelected id du product selectionné
     */
    updateTeamProducerSelected: async function (
      data: ITeamProducer,
      idTeamSelected: string,
      idTeamProductSelected: string
    ): Promise<void> {
      await fcrud(
        'team',
        new MessageNotif(
          ETeamSelectedProducerNotif.UPDATE_SUCCES,
          ETeamSelectedProducerNotif.UPDATE_ERROR
        ).get()
      ).update(data, `${idTeamSelected}/producers/${idTeamProductSelected}`);
    },

    /**
     * upload l'image pour le producer
     * @param file le fichier à telecharger
     * @param idTeamSelected id du team selected
     * @param idTeamProducerSeleted id du producer selected
     */
    uploadImageTeamProducerSelected: async function (
      file,
      idTeamSelected: string,
      idTeamProducerSeleted: string
    ): Promise<void> {
      await fcrud('team', new MessageNotif('', '').get()).uploadImage(
        `articles/teamproducer_${idTeamProducerSeleted}`,
        `${idTeamSelected}/producers/${idTeamProducerSeleted}`,
        file
      );
    },

    /**
     * supprime l'image du producer
     * @param idTeamSelected id de la team selectionné
     * @param idTeamProducerSeleted id du producer selectionné
     */
    deleteImageTeamProducerSelected: async function (
      idTeamSelected: string,
      idTeamProducerSeleted: string
    ): Promise<void> {
      await fcrud('team', new MessageNotif('', '').get()).deleteImage(
        `articles/teamproducer_${idTeamProducerSeleted}`,
        `${idTeamSelected}/producers/${idTeamProducerSeleted}`,
        { image: '' }
      );
    },

    /**
     * stop ecouteur du team producers selectionné
     */
    stopListenTeamProducerSelected: function (): void {
      if (listen_team_producer_selected) {
        listen_team_producer_selected();
      }
    },

    /**
     * reset
     */
    reset: function (): void {
      set({} as ITeamProducer);
    }
  };
}

// store producer selectionné
export const team_producer_selected_store = createStoreTeamProducerSelected();
