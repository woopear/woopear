<script lang="ts">
	import { page } from '$app/stores';
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';

	export let libelle: string;
	export let link: string;
	export let handlerClickA;

	$: textColor =
		$page.path === link
			? 'text-colorthree'
			: 'text-fondPrincipalDark dark:text-fondPrincipalClaire';
</script>

{#if libelle && link}
	<li
		class={`transition-all duration-300 border-b border-gray-300 py-6 text-base ${textColor} hover:text-colorthree md:text-lg md:px-4 md:border-none dark:hover:text-colorthree`}
	>
		<a on:click={handlerClickA} href={link}>{filterStringService.firstToUppperCase(libelle)}</a>
	</li>
{/if}

<!--
  @component

  ## nav-item

  > lien du menu contient un li et un a  
  > tres simple, ces liens sont relier  
  > seulement à des encres  

  ### props

  ```js
  // nom du lien
  export let libelle: string;

  // lien de l'encre
  export let link: string;

  // props pour affecter fonction au click de la balise a
  export let handlerClickA;
  ```

  ### exemple d'utilisation

  ```js
  <NavItem libelle="woopear" link="#coucou" />
  ```

  ### fonctions / variables

  - RAS

  ### les imports

  - RAS

-->
