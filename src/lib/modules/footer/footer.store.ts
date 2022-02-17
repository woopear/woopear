import { writable } from 'svelte/store';

export const storeFooter = () => {
  const { set, subscribe, update } = writable({} as IFooter);
  
}