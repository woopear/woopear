import { writable } from 'svelte/store';
import type { IWebapp } from '../webapp.type';

function createStoreWebappSelected() {
  const { set, subscribe, update } = writable({} as IWebapp);

  return {
    set,
    subscribe,
    update
  };
}

// store webapp selected
export const webapp_selected_store = createStoreWebappSelected();
