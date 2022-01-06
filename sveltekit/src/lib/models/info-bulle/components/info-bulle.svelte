<script lang="ts">
	import LogoError from '$lib/models/logo/components/logo-error.svelte';
	import { infoBubbleStore } from '../stores/info-bulle.store';
	import { constInfoBulleTextComponent } from '../stores/info-bulle.const';
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';
	import LogoClosed from '$lib/models/logo/components/logo-closed.svelte';
	import { infoBulleService } from '../info-bulle.service';

	export let infoBulleError = false;

	$: style = `${$infoBubbleStore.infoBubbleX}; ${$infoBubbleStore.infoBubbleY}`;

	// efface l'erreur en cours
	const closeInfoBulleError = (): void => {
		infoBulleService.resetXAndYInfoBubble();
		infoBulleService.setInfoBubbleError('');
	};
</script>

<!-- info bulle pour passage de la souris -->
{#if $infoBubbleStore.infoBubbleText && infoBulleError === false}
	<div class={`fixed z-50 py-1 px-2 w-fit shadow-xl bg-gray-800 dark:bg-white`} {style}>
		<p class={`text-white dark:text-black text-xs`}>
			{filterStringService.textFormating($infoBubbleStore.infoBubbleText)}
		</p>
	</div>
{/if}

<!-- info bulle pour error -->
{#if $infoBubbleStore.infoBubbleError && infoBulleError === true}
	<div class={`fixed z-50 p-3 w-64 shadow-xl bg-white dark:bg-black`} {style}>
		<LogoClosed handlerClick={closeInfoBulleError} addStyleDiv="ml-auto" />
		<p class="flex items-center mb-2 mt-2">
			<LogoError color="text-red-500" />
			<span class="font-bold text-red-500 pl-2"
				>{filterStringService.textFormating(constInfoBulleTextComponent.title)}</span
			>
		</p>
		<p class={`text-black dark:text-white text-sm`}>
			{filterStringService.textFormating($infoBubbleStore.infoBubbleError)}
		</p>
	</div>
{/if}
