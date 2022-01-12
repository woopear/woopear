import type { IImage } from './../../image/types/image.type';
import { inputImageStore } from './inputImage.store';


export const inputImageMutation = {
  /** 
   * set inputImage
  */
  setInputImage: (value: IImage[]): void => {
    inputImageStore.update((n) => {
      n.inputImage = value;
      return n;
    });
  },

  addImage: (value: IImage): void => {
    inputImageStore.update((i) => {
      i.inputImage = [...i.inputImage, value];
      return i;
    })
  }
}