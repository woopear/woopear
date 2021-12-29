// filter sur les chaines de caractere
export const filterStringService = {
	/**
	 * met en majuscule la premiere lettre d'un mot
	 * @param word => mot à modifier
	 * @returns => retourne le mot modifié
	 */
	firstToUppperCase: (word: string): string => {
		const result = word.charAt(0).toUpperCase() + word.substring(1);

		return result;
	},

	/**
	 * fonction qui formate un long text, espace apres un . ou , ou majuscule apres un .
	 * @param text => text long
	 * @returns retourne le text long formaté
	 */
	textFormating: (text: string): string => {
		let resultPoint = '';
		let result = '';
		const separateurresultPoint = text.split('.');

		for (let i = 0; i < separateurresultPoint.length; i++) {
			if (' ' === separateurresultPoint[i].charAt(0)) {
				resultPoint =
					resultPoint +
					' ' +
					separateurresultPoint[i].charAt(1).toUpperCase() +
					separateurresultPoint[i].substring(2) +
					'.';
			} else {
				resultPoint =
					resultPoint +
					' ' +
					separateurresultPoint[i].charAt(0).toUpperCase() +
					separateurresultPoint[i].substring(1) +
					'.';
			}
		}
		const separateurVirgule = resultPoint.split(',');

		for (let i = 0; i < separateurVirgule.length; i++) {
			if (' ' === separateurVirgule[i].charAt(0) && i !== separateurVirgule.length) {
				result = result + ' ' + separateurVirgule[i].substring(1) + ',';
			} else {
				result = result + ' ' + separateurVirgule[i].substring(0) + ',';
			}
		}

		return result.substring(0, result.length - 2);
	},

	/**
	 * fonction qui ajoute un "à" dans la date tostring()
	 * car cela permet de séparer la date de l'heure avec un text
	 * @param date
	 */
	separateDateOfHours: (date: string, textSeparate: string): string => {
		// on sépare la date de l'heure
		const splitDate = date.split(',');

		// on rejoint les deux avec textSeparate
		return splitDate.join(`${textSeparate}`);
	}
};
