<script lang="ts">
	import Presentation from '$lib/models/presentation/components/presentation.svelte';
	import { presentationService } from '$lib/models/presentation/presentation.service';
	import { presentationStore } from '$lib/models/presentation/stores/presentation.store';
	import { onMount } from 'svelte';

	onMount(async () => {
		// on recupere la presentation
		await presentationService.getPresentation();
	});
</script>

{#if 'id' in $presentationStore.presentation}
	<!-- box presentation -->
	<Presentation presentation={$presentationStore.presentation} />
{/if}
