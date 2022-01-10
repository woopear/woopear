<script lang="ts">
	import { goto } from '$app/navigation';
	import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
	import { EBtnBgColorAction, EBtnSizeAction } from '$lib/models/btn-action/types/btn-action.enum';
	import SubTitleRubric from '$lib/models/sub-title-rubric/components/sub-title-rubric.svelte';
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';
	import { articleMentionStore } from '../stores/article-mention.store';
</script>

<section class="mt-12 ml-4">
	<SubTitleRubric subTitle="Article mention legale : " />

	<BtnAction
		addStyle="mb-8 mt-8"
		textBtn="creer un article"
		sizeBtn={EBtnSizeAction.SMALL}
		typeBtn={EBtnBgColorAction.VALIDATE}
		handlerClick={() => {
			goto('mentions-legales/create-article-mention');
		}}
	/>
	<table class="table-auto border-collapse bg-white border border-gray-200">
		<thead>
			<tr>
				<th class="border border-gray-200" scope="col">id</th>
				<th class="border border-gray-200" scope="col">title</th>
				<th class="border border-gray-200" scope="col">creation</th>
				<th class="border border-gray-200" scope="col">publication</th>
			</tr>
		</thead>
		<tbody>
			{#if $articleMentionStore.articleMentions.length > 0}
				{#each $articleMentionStore.articleMentions as article}
					<tr>
						<td class="border border-gray-200">{article.id}</td>
						<td class="border border-gray-200">{article.title}</td>
						<td class="border border-gray-200"
							>{filterStringService.separateDateOfHours(
								new Date(article.created_at).toLocaleString(),
								' à'
							)}</td
						>
						<td class="border border-gray-200"
							>{filterStringService.separateDateOfHours(
								new Date(article.published_at).toLocaleString(),
								' à'
							)}</td
						>
					</tr>
				{/each}
			{:else}
				<tr>
					<td class="border border-gray-200 p-4" colspan="5"> Aucun artice </td>
				</tr>
			{/if}
		</tbody>
	</table>
</section>
