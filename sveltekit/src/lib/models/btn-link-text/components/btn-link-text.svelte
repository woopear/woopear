<script lang="ts">
	import LogoChevronRight from '$lib/models/logo/components/logo-chevron-right.svelte';

	export let textBtn: string;
	export let myClick;
</script>

{#if textBtn}
	<button class="text-colorone flex text-base items-center md:text-lg" on:click={myClick}>
		<span class="hover:underline mr-1">
			{textBtn}
		</span>
		<LogoChevronRight />
	</button>
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
