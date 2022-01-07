import { graphqlService } from '$lib/models/graphql/graphql.service';
import { EInfoBulleError } from '$lib/models/info-bulle/types/info-bulle.enum';
import { connexionQuery } from '../queries/connexion.query';
import type { IConnextionObject, ILoginReceved } from '../types/connexion.type';
import { connexionMutation } from './connexion.mutation';
import { infoBulleService } from '$lib/models/info-bulle/info-bulle.service';

export const connexionApi = {
	/**
	 * connexion user recupere le login
	 */
	login: async (data: IConnextionObject, e: MouseEvent): Promise<void> => {
		try {
			// connexion
			const res = await graphqlService.request<ILoginReceved>(connexionQuery.login, data);
			console.log(res.login.jwt);

			// on set le store currentLogin
			connexionMutation.setCurrentLogin(res.login);
			// on set le headers
			graphqlService.setHeaders({
				Authorization: `Bearer ${res.login.jwt}`
			});
		} catch (error) {
			// config info bulle
			infoBulleService.setInfoBubbleError(EInfoBulleError.CONNEXION);
			infoBulleService.definePositionXInfoBubble(e, window.innerWidth);
			infoBulleService.definePositionYInfoBubble(e);
			throw new Error(EInfoBulleError.CONNEXION);
		}
	},

	/**
	 * deconnexion du user + reset du header des request
	 */
	logout: (): void => {
		connexionMutation.resetCurrentLogin();
		graphqlService.setHeader('Authorization', '');
	}
};
