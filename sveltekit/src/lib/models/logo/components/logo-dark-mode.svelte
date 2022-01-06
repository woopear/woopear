<script lang="ts">
	import { infoBulleService } from '$lib/models/info-bulle/info-bulle.service';
	import { EInfoBulleLogo } from '$lib/models/info-bulle/types/info-bulle.enum';

	import { logoService } from '$lib/models/logo/logo.service';
	import { afterUpdate, beforeUpdate } from 'svelte';
	import { logoStore } from '../stores/logo.store';

	export let addStyleDiv = '';
	let init: boolean;

	beforeUpdate(() => {
		if ($logoStore.darkMode) {
			document.getElementById('html').classList.add('dark');
		} else {
			document.getElementById('html').classList.remove('dark');
		}
	});

	afterUpdate(() => {
		// apres le chargement du composant
		// on set à true pour afficher le logo
		init = true;
	});

	// entrer de la souris sur le logo
	const mouseEnterDiv = (e: MouseEvent): void => {
		infoBulleService.setInfoBubbleText(EInfoBulleLogo.MODEDARK);
		infoBulleService.definePositionXInfoBubbleText(e, window.innerWidth);
		infoBulleService.definePositionYInfoBubbleText(e);
	};

	// sortie de la souris du logo
	const mouseOutDiv = (): void => {
		infoBulleService.setInfoBubbleText('');
		infoBulleService.resetXAndYInfoBubbleText();
	};
</script>

{#if init}
	<div
		on:mouseenter={mouseEnterDiv}
		on:mouseleave={mouseOutDiv}
		on:click={logoService.activateDisableDarkMode}
		class={`transition-all duration-300 shadow-lg cursor-pointer w-fit h-fit p-2 rounded-full bg-white text-gray-400 ${addStyleDiv} hover:shadow-2xl hover:text-black md:p-2 lg:p-3 dark:hover:text-colorthree`}
	>
		{#if $logoStore.darkMode === false}
			<!-- lune -->
			<svg
				xmlns="http://www.w3.org/2000/svg"
				class="h-6 w-6 md:h-8 md:w-8"
				fill="none"
				viewBox="0 0 24 24"
				stroke="currentColor"
			>
				<path
					stroke-linecap="round"
					stroke-linejoin="round"
					stroke-width="2"
					d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"
				/>
			</svg>
		{:else if $logoStore.darkMode === true}
			<!-- soleil -->
			<svg
				xmlns="http://www.w3.org/2000/svg"
				class="h-6 w-6 md:h-8 md:w-8"
				fill="none"
				viewBox="0 0 24 24"
				stroke="currentColor"
			>
				<path
					stroke-linecap="round"
					stroke-linejoin="round"
					stroke-width="2"
					d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"
				/>
			</svg>
		{/if}
	</div>
{/if}

<!--
  @component

  ## logo-dark-mode

  > logo qui permet de gere le dark mode  
  > il contient une fonction venant du store du logo  
  > cette fonction modifie le store darkMode +  
  > modifie le localstorage afin de garder en memoir  
  > la selection de l'utilisateur  
  > on peux voir aussi que au chargement il test le store darkMode  
  > pour configurer la balise html  

  ### props

  ```js
  // ajouter du style
  export let addStyleDiv = '';
  ```

  ### exemple d'utilisation

  ```js
   <LogoDarkMode />
  ```

  ### fonctions / variables

  ```js
  // fonction qui active/desactive le mode dark
  logoService.activateDisableDarkMode(): void

  // permet d'attendre que le composant soit finis de monter
  let init: boolean;
  ```
  ### les imports

  - RAS

-->
