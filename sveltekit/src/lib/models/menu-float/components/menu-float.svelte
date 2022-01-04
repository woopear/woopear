<script lang="ts">
	import { goto } from '$app/navigation';

	import { page } from '$app/stores';

	import BtnReturnHome from '$lib/models/btn-return-home/components/btn-return-home.svelte';
	import BtnReturnUp from '$lib/models/btn-return-up/components/btn-return-up.svelte';
	import { connexionStore } from '$lib/models/connexion/stores/connexion.store';
	import LogoConnexion from '$lib/models/logo/components/logo-connexion.svelte';
	import LogoDarkMode from '$lib/models/logo/components/logo-dark-mode.svelte';
	import LogoWoopear from '$lib/models/logo/components/logo-woopear.svelte';
</script>

<nav class="transition-all duration-300 fixed p-6 right-0 top-24 z-40 hover:right-0 lg:-right-12">
	<ul>
		<!-- si page accueil + jwt on affiche btn acces dashboard woopear + deconnexion-->
		{#if $page.path === '/' && $connexionStore.currentLogin.jwt}
			<!-- go dashboard -->
			<div
				on:click={() => goto('/dashboard')}
				class={`transition-all duration-300 mb-4 shadow-lg cursor-pointer w-fit h-fit p-2 rounded-full bg-white hover:shadow-2xl hover:text-colorone md:p-2 lg:p-3 dark:hover:text-colorone`}
			>
				<LogoWoopear />
			</div>
			<!-- si page dashboard woopear + jwt on affiche btn acces dashboard woopear + accueil + deconnexion-->
		{:else if $page.path === '/dashboard' && $connexionStore.currentLogin.jwt}
			<!-- go dashboard -->
			<div
				on:click={() => goto('/dashboard')}
				class={`transition-all duration-300 mb-4 shadow-lg cursor-pointer w-fit h-fit p-2 rounded-full bg-white hover:shadow-2xl hover:text-colorone md:p-2 lg:p-3 dark:hover:text-colorone`}
			>
				<LogoWoopear />
			</div>
			<!-- go accueil -->
			<BtnReturnHome addStyleDiv="mb-4" />
		{:else if $page.path === '/'}
			<!-- go connexion -->
			<LogoConnexion addStyleDiv="mb-4" />
		{:else}
			<!-- go accueil -->
			<BtnReturnHome addStyleDiv="mb-4" />
		{/if}

		<LogoDarkMode addStyleDiv="mb-4" />
		<BtnReturnUp addStyleDiv="mb-4" />
	</ul>
</nav>

<!--
  @component

  ## menu-float

  > menu des icon flottant en bas à gauche

  ### props

  - RAS

  ### exemple d'utilisation

  ```js
  <MenuFloat />
  ```

  ### fonctions / variables

  - RAS

  ### les imports

  ```js
  import LogoConnexion from '$lib/models/logo/components/logo-connexion.svelte';
  import LogoDarkMode from '$lib/models/logo/components/logo-dark-mode.svelte';
  ```

-->
