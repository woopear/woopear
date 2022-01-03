<script lang="ts">
	import BoxRubric from '$lib/models/box-rubric/components/box-rubric.svelte';
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';
	import type { IStep } from '../types/step.type';

	export let steps: IStep[];
</script>

{#each steps as step}
	<BoxRubric addStyle="mb-6 shadow-lg sm:w-96 lg:w-96 lg:mx-2 lg:min-h-max lg:h-96">
		<section>
			<img
				class="w-32 h-32 bg-cover rounded-full m-auto"
				src={`${import.meta.env.VITE_URL_API_IMG}${step.image.url}`}
				alt={step.image.alternativeText}
			/>
			<h2 class="font-bold mt-6 mb-2 lg:mt-0 xl:text-lg">
				{filterStringService.firstToUppperCase(step.title)}
			</h2>
			<p class="font-thin xl:text-lg text-justify">
				{filterStringService.textFormating(step.description)}
			</p>
		</section>
	</BoxRubric>
{/each}
