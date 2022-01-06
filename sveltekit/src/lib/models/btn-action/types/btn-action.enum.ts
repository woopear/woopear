/**
 * enum pour déterminer le type de button, cela change le design du btn
 */
export const enum EBtnBgColorAction {
	ERROR = 'bg-red-600 hover:bg-red-600/80',
	VALIDATE = 'bg-colorone hover:bg-colorone/80',
	WARRNING = 'bg-colorthree hover:bg-colorthree/80'
}

/**
 * enum pour déterminer la taille du btn, cela modifie le design
 */
export const enum EBtnSizeAction {
	SMALL = 'px-4 py-1 text-sm',
	MEDIUM = 'px-4 py-2 text-base',
	LARGE = 'px-5 py-2 text-lg'
}
