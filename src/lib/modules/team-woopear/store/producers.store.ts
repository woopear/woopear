import { fcrud, MessageNotif } from '$lib/providers/firebase/firebase-crud';
import { fire_db } from '$lib/providers/firebase/firebase.service';
import { collection, getDocs, onSnapshot, query, type Unsubscribe } from 'firebase/firestore';
import { writable } from 'svelte/store';
import { createTeamProducer, ETeamProducerNotif } from '../team-woopear.const';
import type { ITeamProducer } from '../team-woopear.type';

function createStoreTeamProducers() {
  const { subscribe, set, update } = writable([] as ITeamProducer[]);

  // ecouteur des producers de la team selectionné
  let listen_team_producers: Unsubscribe;

  // sub
  function sub(): ITeamProducer[] {
    let s: ITeamProducer[];
    subscribe((v) => (s = v));
    return s;
  }

  return {
    set,
    subscribe,
    update,

    /**
     * ecouteur du team producers
     * @param idTeamSelected id de la team selectionné
     */
    listenTeamProducers: function (idTeamSelected: string): void {
      listen_team_producers = onSnapshot(
        collection(fire_db, 'team', `${idTeamSelected}/producers`),
        (snapShot) => {
          let team_producers: ITeamProducer[] = [];
          snapShot.forEach((doc) => {
            const obj_team_producers = { id: doc.id, ...doc.data() };
            team_producers = [...team_producers, obj_team_producers];
          });
          set(team_producers);
        }
      );
    },

    /**
     * retourne le tableau de producer du team ciblé
     * @param idWebapp id du team ciblé
     * @returns retourne le tableau de producers
     */
    getTeamProducer: async function (idTeamSelected: string): Promise<ITeamProducer[]> {
      const producers = await getDocs(
        query(collection(fire_db, 'team', `${idTeamSelected}/producers`))
      );
      return producers.docs;
    },

    /**
     * ajoute une personne à la team selected
     * @param idTeamSelected id de la team selected
     */
    addTeamProducer: async function (idTeamSelected: string): Promise<void> {
      await fcrud(
        'team',
        new MessageNotif(ETeamProducerNotif.ADD_SUCCES, ETeamProducerNotif.ADD_ERROR).get()
      ).add(createTeamProducer(), `${idTeamSelected}/producers`);
    },

    /**
     * supprime un producer
     * @param idTeamSelected id de la team selectionné
     * @param idTeamProducer id du producer selectionné
     */
    deleteTeamProducer: async function (
      idTeamSelected: string,
      idTeamProducer: string
    ): Promise<void> {
      // on supprime les images lier au team producer
      const team_producer = sub();
      if (team_producer.length > 0) {
        team_producer.forEach(async (el) => {
          if (el.id === idTeamProducer) {
            if (el.image !== '') {
              await fcrud('team', new MessageNotif('', '').get()).deleteImage(
                `articles/teamproducer_${el.id}`,
                `${idTeamSelected}/producers/${el.id}`
              );
            }
          }
        });
      } else {
        const producers = await this.getTeamProducer(idTeamSelected);
        if (producers.length > 0) {
          producers.forEach(async (el) => {
            if (el.id === idTeamProducer) {
              if (el.image !== '') {
                await fcrud('team', new MessageNotif('', '').get()).deleteImage(
                  `articles/teamproducer_${el.id}`,
                  `${idTeamSelected}/producers/${el.id}`
                );
              }
            }
          });
        }
      }
      await fcrud(
        'team',
        new MessageNotif(ETeamProducerNotif.DELETE_SUCCES, ETeamProducerNotif.DELETE_ERROR).get()
      ).delete(`${idTeamSelected}/producers/${idTeamProducer}`);
    },

    /**
     * stop ecouteur du team producers
     */
    stopListenTeamProducer: function (): void {
      if (listen_team_producers) {
        listen_team_producers();
      }
    },

    /**
     * reset
     */
    reset: function (): void {
      set([] as ITeamProducer[]);
    }
  };
}

// store producers
export const team_producers_store = createStoreTeamProducers();
