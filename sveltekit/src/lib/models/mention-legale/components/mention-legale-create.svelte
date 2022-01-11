<script lang="ts">
	import { goto } from '$app/navigation';
	import { articleMentionStore } from '$lib/models/article-mention/stores/article-mention.store';
	import BoxRubric from '$lib/models/box-rubric/components/box-rubric.svelte';
	import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
	import { EBtnBgColorAction, EBtnSizeAction } from '$lib/models/btn-action/types/btn-action.enum';
	import SubTitleRubric from '$lib/models/sub-title-rubric/components/sub-title-rubric.svelte';
	import TitlePartRubric from '$lib/models/title-part-rubric/components/title-part-rubric.svelte';
	import { formProvider } from '$lib/providers/form/form.service';
	import { mentionLegaleService } from '../mention-legale.service';
	import type { IMention } from '../types/mention-legale.type';

	let event: MouseEvent;
	let articles = [];
	let check = false;

	// recuperation du event click sur le btn pour afficher l'info bulle error à l'endroit du click
	const hanlderClickBtnAction = (e): void => {
		event = e;
	};

	// envoie formulaire creation mention
	const handlerForm = async (e): Promise<void> => {
		// creation du formData
		const formData = formProvider.createFormData<IMention>(e.target);
		formData.activate = check;
		formData.articlementions = articles;

		// on enregistre en bdd
		await mentionLegaleService.createMentionLegale(formData, event);

		// on retourne sur la page mention legale
		goto('/dashboard/mentions-legales');
	};
</script>

<div class="mt-8 ml-6">
	<BtnAction
		textBtn="retour"
		sizeBtn={EBtnSizeAction.MEDIUM}
		typeBtn={EBtnBgColorAction.VALIDATE}
		handlerClick={() => goto('/dashboard/mentions-legales')}
	/>
</div>

<BoxRubric addStyleDiv="my-4 ml-4 mr-16">
	<!-- title -->
	<SubTitleRubric subTitle="Creation d'une mention :" />

	<!-- form creation mention -->
	<form class="mt-8" on:submit|preventDefault={handlerForm}>
		<!-- input activate -->
		<TitlePartRubric text="Activé / Désactivé la mention-légale : " />
		<div class="flex justify-start items-center mb-6 mt-2">
			<input id="activate" type="checkbox" bind:checked={check} />
			<label class="ml-1" for="activate">Activé ou Désactivé</label>
		</div>

		<!-- input check pour liste article -->
		{#if $articleMentionStore.articleMentions.length > 0}
			<TitlePartRubric text="Liste des articles : " />
			{#each $articleMentionStore.articleMentions as article}
				<div class="mt-2">
					<label>
						<input
							type="checkbox"
							bind:group={articles}
							name="articlementions"
							value={article.id}
						/>
						{article.title}
					</label>
				</div>
			{/each}
		{:else}
			<TitlePartRubric text="Liste des articles : " />
			<div>Aucun article</div>
		{/if}

		<!-- btn submit -->
		<div class="mt-6 text-right">
			<BtnAction
				textBtn="enregistrer"
				sizeBtn={EBtnSizeAction.SMALL}
				typeBtn={EBtnBgColorAction.VALIDATE}
				handlerClick={hanlderClickBtnAction}
			/>
		</div>
	</form>
</BoxRubric>
