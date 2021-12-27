<script lang="ts">
	export let color: string;
	export let addStyleDiv = '';
</script>

<div class={`${addStyleDiv}`}>
	<section class={`px-6 py-6 ${color}`}>
		<slot />
	</section>
</div>

<!--
  @component

  ## box-rubric-color  

  > Cadre de rubrique avec fond de couleur  
  > ajouter une background color comme ceci  
  > `bg-[#macouleur]` dans la props `color`  
  > il y a une div qui englobe la box pour  
  > affecter par exemple du padding

  ### props

  ```js
  // ajouter une couleur de fond obligatoire
  export let color: string;

  // ajouter du style à la div qui englobe la box
  export let addStyleDiv = '';
  ```

  ### exemple d'utilisation

  ```js
  <BoxRubricColor color="bg-[#fdeddf]" addStyleDiv="py-2">
	<TitleRubric title="Je suis le titre" />
	<SubTitleRubric subTitle="Je suis le sous titre" />
	<BtnLinkText myClick={undefined} textBtn="En savoir plus" />
  </BoxRubricColor>
  ```

  ### fonctions / variables

  - RAS

  ### les imports  

  - RAS

-->
