<script lang="ts">
	import LogoChevronRight from '$lib/models/logo/components/logo-chevron-right.svelte';
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';

	export let libelle: string;
	export let link: string;
</script>

<li class="text-fondPrincipalDark flex text-xs items-center pt-2 dark:text-fondPrincipalClaire">
	<a class="hover:underline mr-1" href={link}>{filterStringService.firstToUppperCase(libelle)}</a>
	<LogoChevronRight size="h-3 w-3" />
</li>

<!--
  @component

  ## nav-item-footer

  > item du menu du footer  
  > les props sont obligatoire 

  ### props

  ```js
  // le text du lien
  export let libelle: string;

  // url
  export let link: string;
  ```

  ### exemple d'utilisation

  ```js
  <NavItemFooter libelle="Mentions légales" link="#" />
  ```

  ### fonctions / variables

  - RAS

  ### les imports

  ```js
  import LogoChevronRight from '$lib/models/logo/components/logo-chevron-right.svelte';
  ```

-->
