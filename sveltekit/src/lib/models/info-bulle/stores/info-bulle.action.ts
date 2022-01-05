import { EInfoBubbleAddClient } from '../types/info-bulle.enum';
import { infoBulleMutation } from './info-bulle.mutation';

// action du store infobubble
export const infoBubbleAction = {
	/**
	 * fonction qui défini le left de la div info bulle
	 * @param e => evenement de la souris
	 * @param widthWindow => largeur total de la fenetre (window.innerWidth)
	 * @param addClient => variable deja init avec l'enum
	 */
	definePositionXInfoBubble: (
		e: MouseEvent,
		widthWindow: number,
		addClient = EInfoBubbleAddClient.X
	): void => {
		let x = e.clientX + addClient;

		// si x dépasse la motier de la fenetre on inverse la div pour qu'elle reste affiché dans l'écrans
		if (x > widthWindow / 2) {
			x = widthWindow - x + addClient;

			infoBulleMutation.setInfoBubbleX(
				`right: ${x}px; border-bottom-left-radius: 16px; border-bottom-right-radius: 16px; border-top-left-radius: 16px;`
			);
		} else {
			infoBulleMutation.setInfoBubbleX(
				`left: ${x}px; border-bottom-left-radius: 16px; border-bottom-right-radius: 16px; border-top-right-radius: 16px;`
			);
		}
	},

	/**
	 * fonction qui défini le top de la div info bulle
	 * @param e => evenement de la souris
	 * @param addClient => variable deja init avec l'enum
	 */
	definePositionYInfoBubble: (e: MouseEvent, addClient = EInfoBubbleAddClient.Y): void => {
		const y = e.clientY + addClient;

		infoBulleMutation.setInfoBubbleY(`top: ${y}px`);
	}
};
