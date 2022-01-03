/**
 * enum pour déterminer le type de button, cela change le design du btn
 */
export const enum EBtnBgColorAction {
	ERROR = 'bg-red-600 hover:bg-red-500',
	VALIDATE = 'bg-colorone hover:bg-[#4785FF]',
	WARRNING = 'bg-colorthree hover:bg-[#FFD770]'
}

/**
 * enum pour déterminer la taille du btn, cela modifie le design
 */
export const enum EBtnSizeAction {
	SMALL = 'px-4 py-1 text-sm',
	MEDIUM = 'px-4 py-2 text-base',
	LARGE = 'px-5 py-2 text-lg'
}
