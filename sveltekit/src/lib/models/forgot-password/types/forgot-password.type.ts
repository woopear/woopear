import type { ILogin } from '$lib/models/connexion/types/connexion.type';

/**
 * interface pour la creation de l'objet de reset password (envoie à l'api pour modifier le password)
 */
export interface IForgotPasswordObjectRequest {
	code?: string;
	password?: string;
	passwordConfirmation?: string;
}

/**
 * interface pour la reponse reçus apres la modification du mot de passe
 */
export interface IResetPasswordReceved {
	resetPassword?: ILogin;
}
