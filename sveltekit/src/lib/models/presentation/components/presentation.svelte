<script lang="ts">
	import BoxRubricColor from '$lib/models/box-rubric/components/box-rubric-color.svelte';
	import SubTitleRubric from '$lib/models/sub-title-rubric/components/sub-title-rubric.svelte';
	import TextContentRubric from '$lib/models/text-content-rubric/components/text-content-rubric.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
	import type { IPresentation } from '../types/presentation.type';

	export let presentation: IPresentation;
</script>

{#if presentation && 'id' in presentation}
	<!-- partie public -->
	<BoxRubricColor
		color="bg-[#DCFFD6] dark:bg-[#062900] transition-all duration-300"
		addStyleDiv="py-24"
	>
		<section class=" lg:flex lg:items-start lg:justify-center">
			<img
				class="h-32 w-32 m-auto md:w-44 md:h-44 lg:m-0 lg:mr-16 xl:mr-28 xl:w-52 xl:h-52"
				src={presentation.image !== null
					? `${import.meta.env.VITE_URL_API_IMG}${presentation.image.formats.small.url}`
					: '../../../../../static/image-found.png'}
				alt={presentation.image !== null ? presentation.image.alternativeText : 'image non fournis'}
			/>
			<article class="md:w-9/12 md:m-auto lg:m-0 lg:w-8/12 lg:pr-12 xl:w-6/12 xl:pr-0 2xl:w-5/12">
				<TitleRubric title={presentation.title} addStyle="mt-8 lg:mt-0" />
				<SubTitleRubric subTitle={presentation.subTitle} />
				<TextContentRubric text={presentation.description} addStyle="mt-8 text-justify" />
			</article>
		</section>
	</BoxRubricColor>
{:else if presentation && 'id' in presentation}
	<!-- partie admin -->
{/if}
