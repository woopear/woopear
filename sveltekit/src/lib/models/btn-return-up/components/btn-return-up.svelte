<script lang="ts">
	import LogoChevronUp from '$lib/models/logo/components/logo-chevron-up.svelte';

	export let addStyleDiv = '';

	let seeArrowUp = false;
	// au scroll arriver à 300 pixel de scroll on affiche sinon on cache
	window.addEventListener('scroll', () => {
		300 < window.scrollY ? (seeArrowUp = true) : (seeArrowUp = false);
	});

	const backTop = (): void => {
		// !!!! ATTENTION ne fonctionne pas sur safarie, voir pour regler le probleme
		window.scrollTo({
			top: 0,
			left: 0,
			behavior: 'smooth'
		});
	};
</script>

{#if seeArrowUp}
	<button
		on:click={backTop}
		class="class={`transition-all duration-300 shadow-lg cursor-pointer w-fit h-fit p-2 rounded-full bg-white text-gray-400 ${addStyleDiv} hover:shadow-2xl hover:text-colorone md:p-2 lg:p-3 dark:hover:text-colorone`}"
	>
		<LogoChevronUp />
	</button>
{/if}

<!--
  @component

  ## btn-return-up

  > bouton qui fait revenir au dessus de la page  

  ### props

  ```js
  // ajouter du style au btn
  export let addStyleDiv = '';
  ```

  ### exemple d'utilisation

  ```js
  <BtnReturnUp />
  ```

  ### fonctions / variables

  ```js
  // au scroll arriver à 300 pixel de scroll on affiche sinon on cache
	window.addEventListener('scroll', () => {
		300 < window.scrollY ? (seeArrowUp = true) : (seeArrowUp = false);
	});

  // remonter au dessus de la page  
  const backTop = (): void
  ```

  ### les imports

  ```js
  import LogoChevronUp from '$lib/models/logo/components/logo-chevron-up.svelte';
  ```  

-->
