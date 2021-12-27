<script lang="ts">
	import { fly } from 'svelte/transition';

	export let addStyleMain = '';
	export let refresh = '';
</script>

{#key refresh}
	<main
		class={`flex flex-col flex-1 mt-24 ${addStyleMain}`}
		in:fly={{ y: -50, duration: 250, delay: 300 }}
	>
		<slot />
	</main>
{/key}

<!--
  @component

  ## page-transition

  > permet de creer un <main> avec des effets de transition  
  > on peut rajouter du style avec la props `addStyleMain`  
  > le refresh permet de cassé le composant complet quand  
  > cette derniere est modifié

  ### props

  ```js
  // ajouter du style
  export let addStyleMain = '';

  // le path de la page en cour
  export let refresh = '';
  ```

  ### exemple d'utilisation

  ```js
  <PageTransition refresh={$page.path}>
	<slot />
  </PageTransition>
  ```

  ### fonctions / variables

  - RAS

  ### les imports

  - RAS

-->
