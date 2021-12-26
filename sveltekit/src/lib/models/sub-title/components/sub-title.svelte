<script lang="ts">
	export let subTitle: string;
	export let addStyle = '';
</script>

{#if subTitle}
	<h3 class={`text-lg font-thin md:text-xl ${addStyle}`}>{subTitle}</h3>
{/if}

<!--
  @component

  ## sub-title

  > je suis le text en dessous du titre  
  > de la rubrique, on peux ajouter du style  
  > et il faut renseigner le text obligatoirement

  ### props

  ```js
  // le text
  export let subTitle: string;

  // ajouter du style
  export let addStyle = '';
  ```

  ### exemple d'utilisation

  ```js
  <SubTitle subTitle="je suis le petit sub title" />
  ```

  ### fonctions / variables  

  - RAS

  ### les imports  

  - RAS

-->
