<script lang="ts">
	import { goto } from '$app/navigation';
	import { connexionService } from '$lib/models/connexion/connexion.service';
	import { connexionStore } from '$lib/models/connexion/stores/connexion.store';
	import { infoBulleService } from '$lib/models/info-bulle/info-bulle.service';
	import Loader from '$lib/models/loader/components/loader.svelte';
	import { onMount } from 'svelte';

	let loader = true;

	onMount(() => {
		// reset info bulle
		infoBulleService.resetXAndYInfoBubble();
		infoBulleService.resetXAndYInfoBubbleText();
		infoBulleService.setInfoBubbleText('');
		infoBulleService.setInfoBubbleError('');

		// si pas de jwt, deconnexion et retour page connexion
		if (!$connexionStore.currentLogin.user) {
			connexionService.resetCurrentLogin();
			goto('/connexion');
			return;
		}

		loader = false;
	});
</script>

<!-- head -->
<svelte:head>
	<title>Woopear | Tableau de bord</title>
</svelte:head>

{#if loader}
	<Loader />
{:else}
	<p>dashbord</p>
{/if}
