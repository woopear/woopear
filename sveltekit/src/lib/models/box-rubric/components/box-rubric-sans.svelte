<script lang="ts">
	export let addStyle = '';
	export let addStyleDiv = '';
</script>

<div class={`${addStyleDiv}`}>
	<section class={`px-6 py-6 ${addStyle}`}>
		<slot />
	</section>
</div>

<!--
  @component

  ## box-rubric-sans  

  > Cadre qui englobe une rubric  
  > celle ci n'a pas de fond et a les bords rectangulaire  
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
  ```

  ### exemple d'utilisation

  ```js
  <BoxRubricSans>
	<TitleRubric title="Je suis le titre" />
	<SubTitleRubric subTitle="Je suis le sous titre" />
	<BtnLinkText myClick={undefined} textBtn="En savoir plus" />
  </BoxRubricSans>
  ```

  ### fonctions / variables

  - RAS

  ### les imports  

  - RAS

-->
