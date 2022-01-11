<script lang="ts">
	import { articleMentionService } from '$lib/models/article-mention/article-mention.service';
	import BoxRubricSans from '$lib/models/box-rubric/components/box-rubric-sans.svelte';
	import Loader from '$lib/models/loader/components/loader.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';
	import type { IMention } from '../types/mention-legale.type';

	export let mention: IMention;
</script>

{#if mention}
	<BoxRubricSans>
		<TitleRubric title="Mentions légales" />
		<p class="text-xs">Mise à jour le : {new Date(mention.updated_at).toLocaleDateString()}</p>
		{#each mention.articlementions as article}
			<section class="mt-12">
				{#if article.title}
					<h2 class="mb-6 text-xl font-bold lg:text-3xl">
						{filterStringService.firstToUppperCase(article.title)}
					</h2>
				{/if}
				{#if article.subTitle}
					<h4 class="mb-2 text-lg font-thin">{article.subTitle}</h4>
				{/if}
				<p class="text-justify md:w-10/12 lg:w-9/12 xl:w-7/12">{article.content}</p>
			</section>
		{/each}
	</BoxRubricSans>
{:else}
	<Loader />
{/if}
