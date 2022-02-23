import { writable } from 'svelte/store';
import type { IPresentation } from '../presentation.type';

// creation du store presentation active
const createPresentationActiveStore = () => {
  const { set, update, subscribe } = writable({} as IPresentation);

  return {
    set,
    update,
    subscribe
  };
};

// store presentation active
export const presentation_active_store = createPresentationActiveStore();
