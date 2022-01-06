import { infoBulleService } from '$lib/models/info-bulle/info-bulle.service';
import { EInfoBulleError } from '$lib/models/info-bulle/types/info-bulle.enum';
import { notificationService } from '$lib/models/notification/notification.service';
import { constNotificationSendMailResetPassword } from '$lib/models/notification/stores/notification.const';
import { EMethodeFetch } from '$lib/providers/fetch/fetch.enum';
import { fetchProvider } from '$lib/providers/fetch/fetch.service';
import { forgotPasswordService } from '../forgot-password.service';

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
			throw new Error('Veuillez renseigner des identifiants valide !');
		}
	}
};
