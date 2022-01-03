export const formProvider = {
	/**
	 * fonction qui creer un objet depuis un formaData d'un formulaire donné en argument
	 * @param target => formulaire contenant les données
	 * @returns => retourne un object formation avec clef/valeur
	 */
	createFormData: <T>(target: HTMLFormElement): T => {
		const formData = new FormData(target);
		const data = {} as T;
		formData.forEach((v, k) => {
			data[k] = v;
		});
		return data;
	}
};
