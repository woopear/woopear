<script lang="ts">
	import Method from '$lib/models/method/components/method.svelte';
	import Presentation from '$lib/models/presentation/components/presentation.svelte';
	import { presentationService } from '$lib/models/presentation/presentation.service';
	import { presentationStore } from '$lib/models/presentation/stores/presentation.store';
	import { serviceService } from '$lib/models/service/service.service';
	import { methodService } from '$lib/models/method/method.service';
	import { teamService } from '$lib/models/team/team.service';
	import { onMount } from 'svelte';
	import { methodStore } from '$lib/models/method/stores/method.store';
	import Service from '$lib/models/service/components/service.svelte';
	import { serviceStore } from '$lib/models/service/stores/service.store';
	import Team from '$lib/models/team/components/team.svelte';
	import { teamStore } from '$lib/models/team/stores/team.store';
	import Techno from '$lib/models/techno/components/techno.svelte';

	onMount(async () => {
		// on recupere la presentation
		await presentationService.getPresentation();
		// on recupere la method
		await methodService.getMethod();
		// on recupere les services
		await serviceService.getServices();
		// on recupere la team
		await teamService.getTeams();
	});
</script>

<!-- box presentation -->
<Presentation presentation={$presentationStore.presentation} />
<!-- box method -->
<Method method={$methodStore.method} />
<!-- box service -->
<Service services={$serviceStore.services} />
<!-- box team -->
<Team team={$teamStore.team} />
<!-- box techno -->
<Techno />
