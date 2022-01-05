import type { TTextInfoBubble } from '../types/info-bulle.type';
import { infoBubbleStore } from './info-bulle.store';

export const infoBulleMutation = {
	/**
	 * fonction qui set le infoBubbleText
	 * @param text => le text de l'infobulle de type TTextInfoBubble
	 */
	setInfoBubbleText: (text: TTextInfoBubble): void => {
		infoBubbleStore.update((n) => {
			n.infoBubbleText = text;
			return n;
		});
	},

	/**
	 * fonction qui set le infoBubbleError
	 * @param text => le text de l'infobulle de type TTextInfoBubble pour l'erreur
	 */
	setInfoBubbleError: (text: TTextInfoBubble): void => {
		infoBubbleStore.update((n) => {
			n.infoBubbleError = text;
			return n;
		});
	},

	/**
	 * fonction qui set la position X de l'infobulle
	 * @param css => design à affecter
	 */
	setInfoBubbleX: (css: string): void => {
		infoBubbleStore.update((n) => {
			n.infoBubbleX = css;
			return n;
		});
	},

	/**
	 * fonction qui set la position Y de l'infobulle
	 * @param css => design à affecter
	 */
	setInfoBubbleY: (css: string): void => {
		infoBubbleStore.update((n) => {
			n.infoBubbleY = css;
			return n;
		});
	},

	/**
	 * fonction qui reset le left et le top de la div info bulle
	 */
	resetXAndYInfoBubble: (): void => {
		infoBulleMutation.setInfoBubbleY('left: 0px');
		infoBulleMutation.setInfoBubbleX('top: 0px');
	}
};
