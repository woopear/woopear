import { writable } from 'svelte/store';
import type { IConditionContent } from '../condition.type';

// creation store condition gen
function createStoreConditionGenTypeContent() {
  const { subscribe, set, update } = writable([] as IConditionContent[]);

  return {
    subscribe,
    set,
    update
  };
}

// store condition gen
export const condition_gen_type_content_store = createStoreConditionGenTypeContent();
