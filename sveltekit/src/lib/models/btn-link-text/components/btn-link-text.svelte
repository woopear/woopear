<script lang="ts">
	import LogoChevronRight from '$lib/models/logo/components/logo-chevron-right.svelte';
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';

	export let textBtn: string;
	export let colorText = 'text-colorone';
	export let href;
</script>

{#if textBtn}
	<a class={`${colorText} flex text-base items-center md:text-lg`} {href} target="_blank">
		<span class="hover:underline mr-1">
			{filterStringService.firstToUppperCase(textBtn)}
		</span>
		<LogoChevronRight />
	</a>
{/if}

<!--
  @component

  ## btn-link-text

  > bouton de lien ou autre qui permet  
  > d'afficher quelque chose ou de passé  
  > sur une autre page  

  ### props

  ```js
  // text du btn
 export let textBtn: string;

 // couleur du text
 export let colorText = 'text-colorone';

 // la fonction à passé pour qu'elle soit
 // executer au click du btn
 export let myClick;
  ```

  ### exemple d'utilisation

  ```js
  <BtnLinkText textBtn="En savoir plus" myClick={undefined} />
  ```

  ### fonctions / variables

  - RAS

  ### les imports

  ```js
  import LogoChevronRight from '$lib/models/logo/components/logo-chevron-right.svelte';
  ```

-->
