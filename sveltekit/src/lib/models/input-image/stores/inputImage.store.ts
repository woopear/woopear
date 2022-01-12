import type { IImage } from './../../image/types/image.type';
import { writable } from 'svelte/store';

export const inputImageStore = writable({
  inputImage: [] as IImage[]
});
