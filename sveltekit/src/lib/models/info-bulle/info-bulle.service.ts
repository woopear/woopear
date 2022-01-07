import { infoBubbleAction } from './stores/info-bulle.action';
import { infoBulleGetter } from './stores/info-bulle.getter';
import { infoBulleMutation } from './stores/info-bulle.mutation';

export const infoBulleService = {
	...infoBulleGetter,
	...infoBulleMutation,
	...infoBubbleAction
};
