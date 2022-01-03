<script lang="ts">
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';
	import type { IProducer } from '../types/producer.type';

	export let producer: IProducer;
</script>

<section class="flex flex-col items-center mb-16 md:mb-0 md:justify-start md:w-4/12">
	<!-- img -->
	<div
		class="rounded-full bg-cover bg-center h-24 w-24"
		style={`background-image: url("${import.meta.env.VITE_URL_API_IMG}${producer.image.url}");`}
	/>
	<!-- nom -->
	<h1 class="mt-8 mb-2 font-bold text-xl">
		{filterStringService.textFormating(producer.fullName)}
	</h1>
	<!-- qualification -->
	<h4 class="mb-4 font-bold text-base text-colorfour">
		{filterStringService.textFormating(producer.title)}
	</h4>
	<!-- description -->
	<p class="text-center text-lg font-thin md:text-justify">
		{filterStringService.textFormating(producer.description)}
	</p>
</section>
