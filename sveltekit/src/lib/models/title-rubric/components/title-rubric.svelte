<script lang="ts">
	export let title: string;
	export let addStyle = '';
</script>

{#if title}
	<h2
		class={`text-3xl font-bold text-fondPrincipalDark ${addStyle} sm:text-4xl md:text-5xl lg:text-6xl dark:text-white`}
	>
		{title}
	</h2>
{/if}

<!--
  @component

  ## title-rubric

  > titre des rubriques par exemple :  
  > Woopear ou Nos technos ou Services  
  > vous pouvez ajouter du style en props    

  ### props

  ```js
  // title
  export let title: string;  

  // ajouter du style  
  export let addStyle = '';
  ```

  ### exemple d'utilisation

  ```js
  <TitleRubric title="Je suis le titre" />
  ```

  ### fonctions / variables

  - RAS

  ### les imports

  - RAS

-->
