import { inputImageService } from './../inputFile.service';
import type { IImage } from './../../image/types/image.type';
import type { IInputImageCreateReceved, IInputImageDeleteReceved } from './../types/inputFile.type';
import { inputImageMutation } from './inputImage.mutation';
import { inputImageGetter } from './inputImage.getter';
import { EInfoBulleError, EInfoBulleValider } from '$lib/models/info-bulle/types/info-bulle.enum';
import { infoBulleService } from "$lib/models/info-bulle/info-bulle.service";
import { graphqlService } from '$lib/models/graphql/graphql.service';
import { inputImageQuery } from '../query/inputImage.query';


export const inputImageApi = {
  /**
   * création de l'image
   * @param e => le click de la souris
   * @param data => le donnée de la nouvelle image
   */
  createImage: async (e: MouseEvent,data: IImage):Promise<void> => {
    // création de l'image
    const {upload} = await graphqlService.request<IInputImageCreateReceved>(
      inputImageQuery.createImage,{file: data}
    )
      
    // si null ou undefined (vide pas d'erreur)
    if(!upload) {
      // config info bulle
      infoBulleService.setInfoBubbleError(EInfoBulleError.CREATION_IMAGE);
      infoBulleService.definePositionXInfoBubble(e, window.innerWidth);
      infoBulleService.definePositionYInfoBubble(e);
      throw new Error(EInfoBulleError.CREATION_IMAGE);
    }
  
    // ajoute image au store articleMention si existe il le remplace
    inputImageMutation.addImage(upload);
	},

  /**
   * 
   * @param e => le click de la souris
   * @param id => l'id de l'image a effacé
   */
  deleteImage: async (e: MouseEvent, id:string): Promise<void> => {
    const { upload } = await graphqlService.request<IInputImageDeleteReceved>(
      inputImageQuery.deleteImage,
      {id: id}
    )

    // si null ou undefined (vide pas d'erreur)
    if(!upload) {
      // config info bulle
      infoBulleService.setInfoBubbleError(EInfoBulleError.DELETE_IMAGE);
      infoBulleService.definePositionXInfoBubble(e, window.innerWidth);
      infoBulleService.definePositionYInfoBubble(e);
      throw new Error(EInfoBulleError.DELETE_IMAGE);
    }

    // on remove l'image dans le store
    inputImageService.removeImage(upload.id)
  }

  
}




