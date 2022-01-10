<script lang="ts">
	import { goto } from '$app/navigation';
	import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
	import { EBtnBgColorAction, EBtnSizeAction } from '$lib/models/btn-action/types/btn-action.enum';
	import SubTitleRubric from '$lib/models/sub-title-rubric/components/sub-title-rubric.svelte';
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';
	import { mentionLegaleStore } from '../stores/mention-legale.store';
</script>

<section class="mt-12 ml-4">
	<SubTitleRubric subTitle="Mention-légale : " />

	<BtnAction
		addStyle="mb-8 mt-8"
		textBtn="creer une mention"
		sizeBtn={EBtnSizeAction.SMALL}
		typeBtn={EBtnBgColorAction.VALIDATE}
		handlerClick={() => {
			goto('mentions-legales/create-mention');
		}}
	/>
	<table class="table-auto border-collapse bg-white border border-gray-200">
		<thead>
			<tr>
				<th class="border border-gray-200" scope="col">id</th>
				<th class="border border-gray-200" scope="col">activé</th>
				<th class="border border-gray-200" scope="col">articles</th>
				<th class="border border-gray-200" scope="col">creation</th>
				<th class="border border-gray-200" scope="col">publication</th>
			</tr>
		</thead>
		<tbody>
			{#if $mentionLegaleStore.mentionLegales.length > 0}
				{#each $mentionLegaleStore.mentionLegales as mention}
					<tr>
						<td class="border border-gray-200">{mention.id}</td>
						<td class="border border-gray-200">{mention.activate ? 'oui' : 'non'}</td>
						<td class="border border-gray-200">{mention.articlementions.length}</td>
						<td class="border border-gray-200"
							>{filterStringService.separateDateOfHours(
								new Date(mention.created_at).toLocaleString(),
								' à'
							)}</td
						>
						<td class="border border-gray-200"
							>{filterStringService.separateDateOfHours(
								new Date(mention.published_at).toLocaleString(),
								' à'
							)}</td
						>
					</tr>
				{/each}
			{:else}
				<tr>
					<td class="border border-gray-200 p-4" colspan="5"> Aucune mention légale </td>
				</tr>
			{/if}
		</tbody>
	</table>
</section>
