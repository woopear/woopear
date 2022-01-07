import { connexionService } from '$lib/models/connexion/connexion.service';
import { graphqlService } from '$lib/models/graphql/graphql.service';
import { infoBulleService } from '$lib/models/info-bulle/info-bulle.service';
import { EInfoBulleError } from '$lib/models/info-bulle/types/info-bulle.enum';
import { notificationService } from '$lib/models/notification/notification.service';
import { constNotificationSendMailResetPassword } from '$lib/models/notification/stores/notification.const';
import { EMethodeFetch } from '$lib/providers/fetch/fetch.enum';
import { fetchProvider } from '$lib/providers/fetch/fetch.service';
import { forgotPasswordService } from '../forgot-password.service';
import { forgotPasswordQuery } from '../queries/forgot-password.query';
import type {
	IForgotPasswordObjectRequest,
	IResetPasswordReceved
} from '../types/forgot-password.type';

export const forgotPasswordApi = {
	/**
	 * envoie d'un email pour réinitialiser le mot de passe de l'utilisateur
	 * @param email => email de l'utilisateur
	 */
	sendMailForgotPassword: async (email: string, e): Promise<void> => {
		// envoie mail
		const response = await fetchProvider.callApi<{ ok: boolean }>(
			`${import.meta.env.VITE_URL_API}/auth/forgot-password`,
			EMethodeFetch.POST,
			fetchProvider.headersSample(),
			{ email: email }
		);

		// si envoie mail est ok
		// sinon on affiche une infobulle error
		if (response.ok) {
			// affiche notification
			notificationService.addNewNotification(
				constNotificationSendMailResetPassword.SEND_MAIL_RESET_PASSWORD_OK
			);
			// on ferme la modal mot de passe oublié
			forgotPasswordService.disableForgotPassword();
		} else {
			// info bulle error
			infoBulleService.setInfoBubbleError(EInfoBulleError.SEND_MAIL_REST_PASSWORD_NOK);
			infoBulleService.definePositionXInfoBubble(e, window.innerWidth);
			infoBulleService.definePositionYInfoBubble(e);
			throw new Error(EInfoBulleError.SEND_MAIL_REST_PASSWORD_NOK);
		}
	},

	/**
	 * modification du mot de passe
	 */
	updatePassword: async (data: IForgotPasswordObjectRequest, e: MouseEvent): Promise<void> => {
		try {
			// update mot de passe api
			const { resetPassword } = await graphqlService.request<IResetPasswordReceved>(
				forgotPasswordQuery.forgotPassword,
				data
			);
			// on set le store currentLogin
			connexionService.setCurrentLogin(resetPassword);
			// on affecte le token au headers
			graphqlService.setHeaders({
				Authorization: `Bearer ${resetPassword.jwt}`
			});
		} catch (error) {
			// config info bulle
			infoBulleService.setInfoBubbleError(EInfoBulleError.UPDATE_PASSWORD);
			infoBulleService.definePositionXInfoBubble(e, window.innerWidth);
			infoBulleService.definePositionYInfoBubble(e);
			throw new Error(EInfoBulleError.UPDATE_PASSWORD);
		}
	}
};
