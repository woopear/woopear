<script lang="ts">
	import type {
		EBtnBgColorAction,
		EBtnSizeAction
	} from '$lib/models/btn-action/types/btn-action.enum';
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';

	export let textBtn = 'Text';
	export let addStyle = '';
	export let typeBtn: EBtnBgColorAction;
	export let sizeBtn: EBtnSizeAction;
	export let handlerClick;
</script>

<button
	on:click={handlerClick}
	class={`transition-all duration-300 ${typeBtn} ${sizeBtn} ${addStyle} rounded-full text-white font-bold`}
>
	{filterStringService.firstToUppperCase(textBtn)}
</button>

<!--
  @component

  ## btn-action

  > ce btn represente les boutons d'action il on un design particulier  
  > ce design est paramettrer grace à des enum  
  > on peux choisir le type ce qui permet de définir la couleur  
  > on peux definir la taille, il est relier à une fonction  
  > handlerClick qui faudra passer par le parent  

  ### props

  ```js
  // le text du btn
  export let textBtn = 'text';

  // ajouter un style en plus
  export let addStyle = '';

  // le type de btn de type EBtnBgColorAction
  export let typeBtn: EBtnBgColorAction;

  // la taille du btn de type EBtnSizeAction
  export let sizeBtn: EBtnSizeAction;

  // la fonction qui doit etre passé depuis le parent
  export let handlerClick;
  ```

  ### exemple d'utilisation

  ```js
  <BtnAction
    textBtn="Fermer"
    typeBtn={EBtnBgColorAction.ERROR}
    sizeBtn={EBtnSizeAction.SMALL}
    addStyle=""
    handlerClick={errorService.removeError(error)}
  />
  ```

  ### fonctions / variables

  - RAS

  ### les imports

  ```js
    import type {
        EBtnBgColorAction,
        EBtnSizeAction
    } from '$lib/models/btn-action/types/btn-action.enum';
  ```
-->
