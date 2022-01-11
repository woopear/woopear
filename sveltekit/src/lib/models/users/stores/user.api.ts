import { connexionService } from '$lib/models/connexion/connexion.service';
import { graphqlService } from '$lib/models/graphql/graphql.service';
import { infoBulleService } from '$lib/models/info-bulle/info-bulle.service';
import { EInfoBulleError } from '$lib/models/info-bulle/types/info-bulle.enum';
import { userQuery } from '../queries/user.query';
import type { IUserReceved } from '../types/user.type';
import { userMutation } from './user.mutation';

export const userApi = {
	/**
	 * get user current si currentLogin exist
	 */
	getUserCurrent: async (e: MouseEvent): Promise<void> => {
		// sub currentLogin
		const cl = connexionService.getterCurrentLogin();

		// si currentLogin exist
		if (cl.user) {
			// recupere le user en fonction de l'id contenue dans le currentLogin
			const { user } = await graphqlService.request<IUserReceved>(userQuery.getUserCurrent, {
				id: cl.user.id
			});

			// si user est nul
			if (!user) {
				// config info bulle
				infoBulleService.setInfoBubbleError(EInfoBulleError.CONNEXION);
				infoBulleService.definePositionXInfoBubble(e, window.innerWidth);
				infoBulleService.definePositionYInfoBubble(e);
				throw new Error(EInfoBulleError.CONNEXION);
			}

			// set userCurrent
			userMutation.setUserCurrent(user);
		}
	}
};
