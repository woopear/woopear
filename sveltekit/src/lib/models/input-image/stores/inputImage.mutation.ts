import type { IImage } from './../../image/types/image.type';
import { inputImageStore } from './inputImage.store';


export const inputImageMutation = {
  /** 
   * set inputImage
  */
  setInputImage: (inputImages: IImage[]): void => {
    inputImageStore.update((i) => {
      i.inputImages = inputImages;
      return i;
    });
  },

  /**
   * ajouter une image
   * @param value objet de l'image a ajouter
   */
  addImage: (value: IImage): void => {
    inputImageStore.update((i) => {
      // si la mention existe deja on l'enleve
      i.inputImages = i.inputImages.filter((el) => el !== value);
      i.inputImages = [...i.inputImages, value];
      return i;
    })
  },

  removeImage: (id: string): void => {
    inputImageStore.update((i) => {
      // si la mention existe deja on l'enleve
      i.inputImages = i.inputImages.filter((el) => el.id !== id);
      return i;
    })
  }
}