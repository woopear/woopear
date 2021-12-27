<script lang="ts">
	export let libelle: string;
	export let link: string;
</script>

{#if libelle && link}
	<li
		class="transition-all duration-300 border-b border-gray-300 py-6 text-base text-fondPrincipalDark hover:text-colorthree md:text-lg md:px-4 md:border-none dark:text-fondPrincipalClaire dark:hover:text-colorthree"
	>
		<a href={link}>{libelle}</a>
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
