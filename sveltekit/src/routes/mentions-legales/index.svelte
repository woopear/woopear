<script lang="ts">
	import MentionLegale from '$lib/models/mention-legale/components/mention-legale.svelte';
	import { mentionLegaleService } from '$lib/models/mention-legale/mention-legale.service';
	import { mentionLegaleStore } from '$lib/models/mention-legale/stores/mention-legale.store';
	import { onMount } from 'svelte';

	onMount(async () => {
		// on recupere la mention legale activé
		await mentionLegaleService.getMentionActivated();
	});
</script>

<!-- head -->
<svelte:head>
	<title>Woopear | Mentions légales</title>
</svelte:head>

<MentionLegale mention={$mentionLegaleStore.mentionLegaleActivate} />
