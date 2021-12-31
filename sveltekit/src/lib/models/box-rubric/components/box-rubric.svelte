<script lang="ts">
	export let addStyle = '';
	export let addStyleDiv = '';
	export let padding = 'px-6 py-6';
</script>

<div class={`${addStyleDiv}`}>
	<section
		class={`transition-all duration-300 bg-white ${padding} rounded-3xl dark:bg-fondSecondaireDark ${addStyle}`}
	>
		<slot />
	</section>
</div>

<!--
  @component

  ## box-rubric  

  > Cadre qui englobe une rubric  
  > celle ci à un fond blanc et les bords arrondi  
  > la largeur n'est pas définis il faut la définir au   
  > cas par cas afin de réaliser un design non linéaire  
  > il y a une div qui englobe la box pour  
  > affecter par exemple du padding  

  ### props

  ```js
  // ajouter du style pratique pour indiquer la largeur
  export let addStyle = '';

  // ajouter du style à la div qui englobe la box
  export let addStyleDiv = '';

  // modifier le padding du cadre blanc
	export let padding = 'px-6 py-6';
  ```

  ### exemple d'utilisation

  ```js
  <BoxRubric>
	<TitleRubric title="Je suis le titre" />
	<SubTitleRubric subTitle="Je suis le sous titre" />
	<BtnLinkText myClick={undefined} textBtn="En savoir plus" />
  </BoxRubric>
  ```

  ### fonctions / variables

  - RAS

  ### les imports  

  - RAS

-->
