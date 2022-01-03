<script lang="ts">
	import { page } from '$app/stores';

	import BtnReturnHome from '$lib/models/btn-return-home/components/btn-return-home.svelte';
	import BtnReturnUp from '$lib/models/btn-return-up/components/btn-return-up.svelte';
	import LogoConnexion from '$lib/models/logo/components/logo-connexion.svelte';
	import LogoDarkMode from '$lib/models/logo/components/logo-dark-mode.svelte';
</script>

<nav class="transition-all duration-300 fixed p-6 right-0 top-28 z-40 hover:right-0 lg:-right-12">
	<ul>
		{#if $page.path === '/'}
			<LogoConnexion addStyleDiv="mb-4" />
		{:else}
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
