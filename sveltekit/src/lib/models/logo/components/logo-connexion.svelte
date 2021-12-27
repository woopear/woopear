<script lang="ts">
	import { goto } from '$app/navigation';
	import { page } from '$app/stores';

	export let addStyleDiv = '';
</script>

<div
	on:click={() => goto('/connexion')}
	class={`transition-all duration-300 shadow-lg cursor-pointer w-fit h-fit p-2 rounded-full bg-white ${addStyleDiv} hover:shadow-2xl hover:text-colorone md:p-2 lg:p-3 dark:hover:text-colorone ${
		$page.path === 'connexion' ? 'text-colorone' : 'text-gray-400'
	}`}
>
	<svg
		xmlns="http://www.w3.org/2000/svg"
		class="h-6 w-6 md:h-8 md:w-8 lg:h-10 lg:w-10"
		fill="none"
		viewBox="0 0 24 24"
		stroke="currentColor"
	>
		<path
			stroke-linecap="round"
			stroke-linejoin="round"
			stroke-width="2"
			d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
		/>
	</svg>
</div>

<!--
  @component

  ## logo-connexion

  > logo d'accès à la page connexion  

  ### props

  ```js
  // ajouter du style
  export let addStyleDiv = '';
  ```

  ### exemple d'utilisation

  ```js
  <LogoConnexion />
  ```

  ### fonctions / variables

  ```js
  on:click={() => goto('/connexion')}
  ```

  ### les imports

  - RAS

-->
