import { writable } from 'svelte/store';

/**
 * fonction qui creer un observable pour afficher/cacher le menu dashboard
 * @returns writable pour afficher ou cacher le menu dashboard
 */
const createSeeMenuDashboardStore = () => {
  const { set, update, subscribe } = writable('-ml-16');

  return {
    set,
    update,
    subscribe,

    /**
     * affiche menu
     */
    active(): void {
      update((n) => (n = 'ml-0'));
    },

    /**
     * cache menu
     */
    disable(): void {
      update((n) => (n = '-ml-16'));
    }
  };
};

// store menu dashboard
export const see_menu_dashboard_store = createSeeMenuDashboardStore();

/**
 * creation d'un writable pour la gerer la class du menu sandwich
 * @returns writable pour la class du btn sandwich
 */
const createActionBtnMenuSand = () => {
  const { set, update, subscribe } = writable('sand');

  return {
    set,
    update,
    subscribe,

    active(): void {
      update((n) => (n = 'active-sand'));
    },

    disable(): void {
      update((n) => (n = 'sand'));
    }
  };
};

// store du menu sandwich
export const action_menu_sand_store = createActionBtnMenuSand();
