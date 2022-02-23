import { writable } from 'svelte/store';
import type { ICondition } from '../condition.type';

// creation store condition gen
function createStoreConditionGenType() {
  const { subscribe, set, update } = writable([] as ICondition[]);

  return {
    subscribe,
    set,
    update
  };
}

// store condition gen
export const condition_gen_type_store = createStoreConditionGenType();
