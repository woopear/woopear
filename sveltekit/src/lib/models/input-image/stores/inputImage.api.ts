import type { IInputImageCreateReceved, IInputImageUpdateReceved } from './../types/inputFile.type';
import { inputImageMutation } from './inputImage.mutation';
import { inputImageGetter } from './inputImage.getter';
import { EInfoBulleError, EInfoBulleValider } from '$lib/models/info-bulle/types/info-bulle.enum';
import { infoBulleService } from "$lib/models/info-bulle/info-bulle.service";
import { graphqlService } from '$lib/models/graphql/graphql.service';
import { inputImageQuery } from '../query/inputImage.query';


export const inputImageApi = {
  /**
   * 
   */
  createImage: async (e,data):Promise<void> => {
    try{
      

      const {createImage} = await graphqlService.request<IInputImageCreateReceved>(
        inputImageQuery.createImage,{data: data}
      )
      
  
      // set le store 
      inputImageMutation.addImage(createImage.inputImage);
    } catch(error){
			// config info bulle
			infoBulleService.setInfoBubbleError(EInfoBulleError.CREATION_IMAGE);
			infoBulleService.definePositionXInfoBubble(e, window.innerWidth);
			infoBulleService.definePositionYInfoBubble(e);
			throw new Error(EInfoBulleError.CREATION_IMAGE);
		}

  },




}