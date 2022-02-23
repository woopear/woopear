import { writable } from 'svelte/store';
import type { IConditionGeneral } from '../condition.type';

// creation store condition gen
function createStoreConditionGen() {
  const { subscribe, set, update } = writable([] as IConditionGeneral[]);

  return {
    subscribe,
    set,
    update
  };
}

// store condition gen
export const condition_gen_store = createStoreConditionGen();
