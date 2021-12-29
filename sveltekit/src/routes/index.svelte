<script lang="ts">
	import BoxRubricColor from '$lib/models/box-rubric/components/box-rubric-color.svelte';
	import { presentationService } from '$lib/models/presentation/presentation.service';
	import { presentationStore } from '$lib/models/presentation/stores/presentation.store';
	import SubTitleRubric from '$lib/models/sub-title-rubric/components/sub-title-rubric.svelte';
	import TextContentRubric from '$lib/models/text-content-rubric/components/text-content-rubric.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
	import { onMount } from 'svelte';

	onMount(async () => {
		await presentationService.getPresentation();
	});
</script>

<!-- box presentation -->
{#if 'id' in $presentationStore.presentation}
	<BoxRubricColor color="bg-[#DCFFD6]">
		<div id="woopear" class="lg:flex lg:items-start lg:justify-center lg:mt-8">
			<img
				class="h-32 w-32 m-auto md:w-44 md:h-44 lg:m-0 lg:mr-16 xl:mr-28 xl:w-52 xl:h-52"
				src={`${import.meta.env.VITE_URL_API_IMG}${$presentationStore.presentation.image.url}`}
				alt={$presentationStore.presentation.image.alternativeText}
			/>
			<div class="md:w-9/12 md:m-auto lg:m-0 lg:w-8/12 lg:pr-12 xl:w-6/12 xl:pr-0 2xl:w-5/12">
				<TitleRubric title={$presentationStore.presentation.title} addStyle="mt-8 lg:mt-0" />
				<SubTitleRubric subTitle={$presentationStore.presentation.subTitle} />
				<TextContentRubric
					text={$presentationStore.presentation.description}
					addStyle="mt-8 text-justify"
				/>
			</div>
		</div>
	</BoxRubricColor>
{/if}
