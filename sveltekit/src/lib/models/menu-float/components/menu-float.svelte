<script lang="ts">
	import BtnReturnUp from '$lib/models/btn-return-up/components/btn-return-up.svelte';
	import LogoConnexion from '$lib/models/logo/components/logo-connexion.svelte';
	import LogoDarkMode from '$lib/models/logo/components/logo-dark-mode.svelte';
</script>

<nav class="fixed right-6 bottom-12 z-40">
	<ul>
		<LogoConnexion addStyleDiv="mb-4" />
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
