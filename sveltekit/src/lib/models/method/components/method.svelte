<script lang="ts">
	import BoxRubricSans from '$lib/models/box-rubric/components/box-rubric-sans.svelte';
	import Step from '$lib/models/step/components/step.svelte';
	import TextContentRubric from '$lib/models/text-content-rubric/components/text-content-rubric.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
	import type { IMethod } from '../types/method.type';

	export let method: IMethod;
</script>

{#if method && 'id' in method}
	<!-- partie public -->
	<BoxRubricSans>
		<section class="py-12 md:py-16 md:w-9/12 md:m-auto lg:w-8/12 lg:text-center xl:w-6/12">
			<TitleRubric title={method.title} />
			<TextContentRubric text={method.description} addStyle="mt-8 text-justify lg:text-center" />
		</section>
	</BoxRubricSans>
	{#if method.steps.length > 0}
		<div
			class="px-4 sm:flex sm:flex-col sm:items-center lg:flex-row lg:flex-wrap lg:items-stretch lg:justify-around"
		>
			<Step steps={method.steps} />
		</div>
	{/if}
{:else if method && 'id' in method}
	<!-- partie admin -->
{/if}
