<script lang="ts">
	import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
	import LogoError from '$lib/models/logo/components/logo-error.svelte';
	import { EBtnBgColorAction, EBtnSizeAction } from '$lib/models/btn-action/types/btn-action.enum';
	import { errorStore } from '$lib/models/error/stores/error.store';
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';
	import { errorService } from '../error.service';
</script>

<!-- si il y a une erreur dans le tableau -->
{#if $errorStore.error.length > 0}
	<section
		class="fixed top-10 right-8 z-40 text-fondPrincipalDark dark:text-fondPrincipalClaire w-7/12 sm:w-5/12 md:w-4/12 xl:w-3/12"
	>
		{#each $errorStore.error as error}
			<div
				class="transition-all duration-300 bg-white py-4 px-4 rounded-2xl mb-6 shadow-lg dark:bg-fondSecondaireDark"
			>
				<!-- title -->
				<p class="text-red-500 font-bold mb-2 flex">
					<LogoError color="text-red-500" /> <span class="ml-2">Une erreur est survenu</span>
				</p>
				<!-- text de l'erreur -->
				<p class="text-sm">{filterStringService.textFormating(error)}</p>
				<!-- btn fermeture -->
				<div class="text-right mt-4">
					<BtnAction
						textBtn="Fermer"
						typeBtn={EBtnBgColorAction.ERROR}
						sizeBtn={EBtnSizeAction.SMALL}
						addStyle=""
						handlerClick={errorService.removeError(error)}
					/>
				</div>
			</div>
		{/each}
	</section>
{/if}

<!--
  @component

  ## error

  > composant error, permet d'afficher les erreurs qui peuvent arriver  
  > en interne du site afin de prévenir l'utilisateur,  
  > ce composant prend un tableau d'erreur et affiche les erreurs une par une  
  > ensuite l'utilisateur peux à l'aide du clique du btn fermer
  > supprimer l'erreur afficher.  

  ### props

  - RAS

  ### exemple d'utilisation

  ```js
  <Error />
  ```

  ### fonctions / variables

  ```js
  // supprime l'erreur en parametre
  errorService.removeError(error: string): void
  ```

  ### les imports

  ```js
  import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
  import LogoError from '$lib/models/logo/components/logo-error.svelte';

  ```

-->
