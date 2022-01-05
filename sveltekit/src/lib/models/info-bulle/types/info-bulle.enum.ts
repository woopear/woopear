/**
 * aTTENTION si vous rajouter ici un nouvel ENUM
 * vous devez rajouter cette ENUM dans le type
 * infobulle qui est dans le dossier types
 */

/**
 * enum pour toutes les erreurs du site
 */
export const enum EInfoBulleError {
	CONNEXION = 'Vos identifiant sont incorrect.'
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
	CONNEXION = 'Vous connectez'
}
