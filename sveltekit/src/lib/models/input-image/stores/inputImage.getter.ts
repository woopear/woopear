import { inputImageStore } from './inputImage.store';
import type { IImage } from './../../image/types/image.type';


export const inputImageGetter = {
  /**
   * 
   */
  getterImages: (): IImage[] => {
    let i: IImage[];
    inputImageStore.subscribe((v) => (
      i= v.inputImage
    ))
    return i;
  }
}