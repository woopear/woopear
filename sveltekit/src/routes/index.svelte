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
	import { technoService } from '$lib/models/techno/techno.service';
	import { technoStore } from '$lib/models/techno/stores/techno.store';
	import Contact from '$lib/models/contact/components/contact.svelte';
	import { contactService } from '$lib/models/contact/contact.service';
	import { contactStore } from '$lib/models/contact/stores/contact.store';
	import Product from '$lib/models/product/components/product.svelte';
	import { productService } from '$lib/models/product/product.service';
	import { productStore } from '$lib/models/product/stores/product.store';

	onMount(async () => {
		// on recupere la presentation
		await presentationService.getPresentation();
		// on recupere la method
		await methodService.getMethod();
		// on recupere les services
		await serviceService.getServices();
		// on recupere la team
		await teamService.getTeams();
		// on recupere les realisations
		await productService.getProducts();
		// on recupere les technos
		await technoService.getTechnos();
		// on recupere contact
		await contactService.getContact();
	});
</script>

<div id="woopear" />
<!-- box presentation -->
<Presentation presentation={$presentationStore.presentation} />

<div id="methode" />
<!-- box method -->
<Method method={$methodStore.method} />

<div id="service" />
<!-- box service -->
<Service services={$serviceStore.services} />

<div id="equipe" />
<!-- box team -->
<Team team={$teamStore.team} />

<div id="realisation" />
<!-- partie product -->
<Product products={$productStore.products} />

<!-- box techno -->
<Techno technos={$technoStore.technos} />

<div id="contact" />
<!-- partie contact -->
<Contact contact={$contactStore.contact} />
