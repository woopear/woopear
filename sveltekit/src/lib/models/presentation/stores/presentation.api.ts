import { EInfoBulleError, EInfoBulleValider } from '$lib/models/info-bulle/types/info-bulle.enum';
import { infoBulleService } from '$lib/models/info-bulle/info-bulle.service';
import type { IPresentation, IPresentationUpdateReceved } from './../types/presentation.type';
import { errorService } from '$lib/models/error/error.service';
import { graphqlService } from '$lib/models/graphql/graphql.service';
import { presentationQuery } from '../queries/presentation.query';
import type { IPresentationReceved } from '../types/presentation.type';
import { presentationGetter } from './presentation.getter';
import { presentationMutation } from './presentation.mutation';

export const presentationApi = {
	/**
	 * recupere presentation call api
	 */
	getPresentation: async (): Promise<void> => {
		// sub à presentation
		const p = presentationGetter.getterPresentation();

		// si presentation n'est pas encore initialiser
		if (p === null || 'id' in p === false) {
			// recuperation
			const { presentation } = await graphqlService.request<IPresentationReceved>(
				presentationQuery.getPresentation
			);

			// test si error
			if (!presentation) {
				const message = 'il y a eu un probleme à la recuperation de la presentation';
				errorService.addNewError(message);
				throw new Error(message);
			}

			// set le store
			presentationMutation.setPresentation(presentation);
		}
	},

	/**
	 * modification de la presentation
	 * @param data le formdata de la modifcation effectuer
	 * @param e l'event du click a la modification
	 */
	updatePresentation: async (data: IPresentation, e: MouseEvent):Promise<void> => {

		try{
			const {updatePresentation} = await graphqlService.request<IPresentationUpdateReceved>(
				presentationQuery.updatePresentation,{data: data}
				);
				// config info bulle
				infoBulleService.setInfoBubbleText(EInfoBulleValider.PRESENTATION)
				
				// sub à presentation
				const p = presentationGetter.getterPresentation();
				
				// set le store
				presentationMutation.setPresentation(updatePresentation.presentation);
		} catch(error){
			// config info bulle
			infoBulleService.setInfoBubbleError(EInfoBulleError.MODIFICATION_PRESENTATION);
			infoBulleService.definePositionXInfoBubble(e, window.innerWidth);
			infoBulleService.definePositionYInfoBubble(e);
			throw new Error(EInfoBulleError.MODIFICATION_PRESENTATION);
		}
	}
};
