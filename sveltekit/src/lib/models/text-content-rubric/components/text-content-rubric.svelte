<script lang="ts">
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';

	export let text: string;
	export let addStyle = '';
</script>

{#if text}
	<p class={`text-lg ${addStyle}`}>
		{filterStringService.firstToUppperCase(text)}
	</p>
{/if}

<!--
  @component

  ## text-content-rubric

  > composant qu formate le text des rubrics  
  > afin d'avoir un design uniforme  

  ### props

  ```js
  // le text obligatoire
  export let text: string;

  // ajouter du style
  export let addStyle = '';
  ```

  ### exemple d'utilisation

  ```js
  <TextContentRubric text="je suis le text formater"/>
  ```

  ### fonctions / variables

  - RAS

  ### les imports

  - RAS

-->
