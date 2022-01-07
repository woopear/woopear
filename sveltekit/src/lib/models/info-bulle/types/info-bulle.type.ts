import type { EInfoBulleError, EInfoBulleLogo, EInfoBulleValider } from './info-bulle.enum';

/**
 * tous les type d'enum dans un seul type
 * pour la fonction de configuration des info bubble
 */
export type TTextInfoBubble = EInfoBulleError | '' | EInfoBulleLogo | EInfoBulleValider;
