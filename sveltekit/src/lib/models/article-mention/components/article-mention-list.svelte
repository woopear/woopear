<script lang="ts">
	import { goto } from '$app/navigation';

	import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
	import { EBtnBgColorAction, EBtnSizeAction } from '$lib/models/btn-action/types/btn-action.enum';
	import { articleMentionStore } from '../stores/article-mention.store';
</script>

<section class="mt-12 ml-4">
	<BtnAction
		addStyle="mb-8"
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
						<td class="border border-gray-200">{article.created_at}</td>
						<td class="border border-gray-200">{article.published_at}</td>
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
