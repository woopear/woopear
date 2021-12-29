<script lang="ts">
	import Method from '$lib/models/method/components/method.svelte';
	import Presentation from '$lib/models/presentation/components/presentation.svelte';
	import { presentationService } from '$lib/models/presentation/presentation.service';
	import { presentationStore } from '$lib/models/presentation/stores/presentation.store';
	import { methodService } from '$lib/models/method/method.service';
	import { onMount } from 'svelte';
	import { methodStore } from '$lib/models/method/stores/method.store';

	onMount(async () => {
		// on recupere la presentation
		await presentationService.getPresentation();
		// on recupere la method
		await methodService.getMethod();
	});
</script>

<!-- box presentation -->
<Presentation presentation={$presentationStore.presentation} />
<!-- box method -->
<Method method={$methodStore.method} />
