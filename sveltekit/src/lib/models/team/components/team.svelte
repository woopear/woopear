<script lang="ts">
	import BoxRubricColor from '$lib/models/box-rubric/components/box-rubric-color.svelte';
	import Producer from '$lib/models/producer/components/producer.svelte';
	import SubTitleRubric from '$lib/models/sub-title-rubric/components/sub-title-rubric.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
	import type { ITeam } from '../types/team.type';

	export let team: ITeam;
</script>

{#if team && 'id' in team}
	<BoxRubricColor color="bg-[#D6E4FF] dark:bg-[#00143d] transition-all duration-300">
		<section class="py-12">
			<!-- title + subtitle -->
			<div class="text-center md:flex md:flex-col md:items-center">
				<TitleRubric title={team.title} addStyle="mb-8" />
				<SubTitleRubric subTitle={team.description} addStyle="md:w-9/12 xl:w-6/12" />
			</div>
			<!-- producers -->
			<article
				class="mt-20 flex flex-col items-center md:flex-row md:justify-evenly md:items-stretch"
			>
				{#each team.producers as producer}
					<Producer {producer} />
				{/each}
			</article>
		</section>
	</BoxRubricColor>
{/if}
