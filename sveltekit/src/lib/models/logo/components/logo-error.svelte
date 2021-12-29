<script lang="ts">
	export let size = 'h-6 w-6';
	export let color = '';
</script>

<svg
	xmlns="http://www.w3.org/2000/svg"
	class={`${size} ${color}`}
	fill="none"
	viewBox="0 0 24 24"
	stroke="currentColor"
>
	<path
		stroke-linecap="round"
		stroke-linejoin="round"
		stroke-width="2"
		d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
	/>
</svg>

<!--
  @component

  ## logo-error

  > petit logo de point d'exclamation  
  > pour les warning ou error, la props 
  > color permet de modifier la couleur  
  > mais vous devez la parametrer avec  
  > `text-`  

  ### props

  ```js
  // modifier la taille
  export let size = 'h-6 w-6';

  // modifier la couleur
  export let color = '';
  ```

  ### exemple d'utilisation

  ```js
  <LogoError color="text-red-500" />
  ```

  ### fonctions / variables

  - RAS

  ### les imports

  - RAS

-->
