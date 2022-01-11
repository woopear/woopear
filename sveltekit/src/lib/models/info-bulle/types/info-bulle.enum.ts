/**
 * aTTENTION si vous rajouter ici un nouvel ENUM
 * vous devez rajouter cette ENUM dans le type
 * infobulle qui est dans le dossier types
 */

/**
 * enum pour toutes les erreurs du site
 */
export const enum EInfoBulleError {
	CONNEXION = 'Vos identifiant sont incorrect.',
	GET_USER_CURRENT = "L'utilisateur n'existe plus, ou l'utilisateur ne corresponds pas aux identifiants",
	SEND_MAIL_REST_PASSWORD_NOK = "Impossible de faire votre demande, l'email n'existe pas, contacter woopear pour ouvrir un compte.",
	UPDATE_PASSWORD = 'Une erreur est survenu, impossible de modifier le mot de passe',
	MODIFICATION_PRESENTATION = 'Une erreur est survenu pendant la modification de la présentation',
	MODIFICATION_INPUTFILE = "Une erreur est survenu pendant la modification du fichier"
}

/**
 * constante utiliser pour ajouter de l'espace au infobulle
 * generé par le passage de la souris, stocker ces valeurs ici
 * permet un accès plus rapide si des modifications doivent etre apportées
 */
export const enum EInfoBubbleAddClient {
	X = 30,
	Y = 10
}

export const enum EInfoBulleLogo {
	MODEDARK = 'Activer / Désactiver mode sombre',
	HOME = "Retour à l'accueil",
	DASHBOARD = 'Votre tableau de bord',
	DISCONNECT = 'Vous déconnectez',
	CONNEXION = 'Vous connectez',
}
/**
 * enum pour dire que l'action effectuer s'est bien passé
 */
export const enum EInfoBulleValider {
	PRESENTATION = 'Modification présentation réussi',
	INPUTFILE = 'Modification inputFile réussi'
}
