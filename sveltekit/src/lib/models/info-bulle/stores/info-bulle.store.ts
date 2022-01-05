import { writable } from 'svelte/store';
import type { TTextInfoBubble } from '../types/info-bulle.type';

// store infoBubble
export const infoBubbleStore = writable({
	infoBubbleText: '' as TTextInfoBubble,
	infoBubbleError: '' as TTextInfoBubble,
	infoBubbleX: '',
	infoBubbleY: '',
	infoBubbleXText: '',
	infoBubbleYText: ''
});
