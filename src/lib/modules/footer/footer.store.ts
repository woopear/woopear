import { writable } from 'svelte/store';
import type { IFooter } from './footer.type';

export const storeFooter = () => {
  const { set, subscribe, update } = writable({} as IFooter);
};
