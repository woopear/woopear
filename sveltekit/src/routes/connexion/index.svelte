<script>
	import Connexion from '$lib/models/connexion/components/connexion.svelte';
	import { infoBulleService } from '$lib/models/info-bulle/info-bulle.service';
	import { onMount } from 'svelte';

	onMount(() => {
		// reset info bulle
		infoBulleService.resetXAndYInfoBubble();
		infoBulleService.resetXAndYInfoBubbleText();
		infoBulleService.setInfoBubbleText('');
		infoBulleService.setInfoBubbleError('');
	});
</script>

<!-- head -->
<svelte:head>
	<title>Woopear | Connexion</title>
</svelte:head>

<div class="flex flex-1 items-center justify-center">
	<Connexion />
</div>
