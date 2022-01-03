<script lang="ts">
	import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
	import { EBtnBgColorAction, EBtnSizeAction } from '$lib/models/btn-action/types/btn-action.enum';
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';
	import { notificationService } from '../notification.service';
	import { constNotification } from '../stores/notification.const';
	import { notificationStore } from '../stores/notification.store';
	import LogoEmojiHappy from '$lib/models/logo/components/logo-emoji-happy.svelte';
</script>

<!-- si il y a une notification dans le tableau -->
{#if $notificationStore.notifications.length > 0}
	<section
		class="fixed top-10 right-8 text-fondPrincipalDark dark:text-fondPrincipalClaire w-7/12 sm:w-5/12 md:w-4/12 xl:w-3/12 z-50"
	>
		{#each $notificationStore.notifications as notification}
			<div
				class="transition-all duration-300 bg-white py-4 px-4 rounded-2xl mb-6 shadow-lg dark:bg-fondSecondaireDark"
			>
				<!-- title -->
				<p class="text-green-500 font-bold mb-2 flex">
					<LogoEmojiHappy color="text-green-500" />
					<span class="ml-2">{constNotification.titleNotification}</span>
				</p>
				<!-- text de la notification -->
				<p class="text-sm">{filterStringService.textFormating(notification)}</p>
				<!-- btn fermeture -->
				<div class="text-right mt-4">
					<BtnAction
						textBtn="Fermer"
						typeBtn={EBtnBgColorAction.VALIDATE}
						sizeBtn={EBtnSizeAction.SMALL}
						addStyle=""
						handlerClick={() => notificationService.removeNotification(notification)}
					/>
				</div>
			</div>
		{/each}
	</section>
{/if}

<!--
  @component

  ## notification

  > composant notification, permet d'afficher les notification qui peuvent arriver  
  > en interne du site afin de prévenir l'utilisateur,  
  > ce composant prend un tableau d'notification et affiche les notification une par une  
  > ensuite l'utilisateur peux à l'aide du clique du btn fermer
  > supprimer la notification afficher.  

  ### props

  - RAS

  ### exemple d'utilisation

  ```js
  <Notification />
  ```

  ### fonctions / variables

  ```js
  // supprime l'erreur en parametre
  notificationService.removeNotification(value: string): void
  ```

  ### les imports

  ```js
  import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
  import LogoError from '$lib/models/logo/components/logo-error.svelte';

  ```

-->
