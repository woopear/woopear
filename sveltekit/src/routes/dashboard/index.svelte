<script lang="ts">
	import { goto } from '$app/navigation';
	import { connexionService } from '$lib/models/connexion/connexion.service';
	import { connexionStore } from '$lib/models/connexion/stores/connexion.store';
	import Loader from '$lib/models/loader/components/loader.svelte';
	import { onMount } from 'svelte';

	let loader = true;

	onMount(() => {
		// si pas de jwt, deconnexion et retour page connexion
		if (!$connexionStore.currentLogin.user) {
			connexionService.resetCurrentLogin();
			goto('/connexion');
			return;
		}

		loader = false;
	});
</script>

{#if loader}
	<Loader />
{:else}
	<p>dashbord</p>
{/if}
