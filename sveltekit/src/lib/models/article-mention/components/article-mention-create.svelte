<script lang="ts">
	import { goto } from '$app/navigation';

	import BoxRubric from '$lib/models/box-rubric/components/box-rubric.svelte';
	import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
	import { EBtnBgColorAction, EBtnSizeAction } from '$lib/models/btn-action/types/btn-action.enum';
	import Input from '$lib/models/input/components/input.svelte';
	import SubTitleRubric from '$lib/models/sub-title-rubric/components/sub-title-rubric.svelte';
	import Textarea from '$lib/models/textarea/textarea.svelte';
	import TitlePartRubric from '$lib/models/title-part-rubric/components/title-part-rubric.svelte';
	import { formProvider } from '$lib/providers/form/form.service';
	import { articleMentionService } from '../article-mention.service';
	import type { IArticleMention } from '../types/article-mention.type';

	let valuetitle = '';
	let valueSubTitle = '';
	let valueContent = '';
	let event: MouseEvent;

	// click btn formulaire
	const hanlderClickBtnAction = (e) => {
		event = e;
	};

	// envoie du formulaire
	const handlerForm = async (e) => {
		// creation du formData
		const formData = formProvider.createFormData<IArticleMention>(e.target);

		// on enregistre en bdd
		await articleMentionService.createArticleMention(formData);

		// on retourne sur la page mention legale
		goto('/dashboard/mentions-legales');
	};
</script>

<BoxRubric addStyleDiv="my-4 ml-4 mr-16">
	<!-- title -->
	<SubTitleRubric subTitle="Creation d'un article pour une mention :" />

	<form class="mt-8" on:submit|preventDefault={handlerForm}>
		<!-- title -->
		<div>
			<TitlePartRubric text="Ajouter un titre : " />
			<Input required={true} placeholder="Mon titre" name="title" bind:value={valuetitle} />
		</div>

		<!-- subtitle -->
		<div class="mt-8">
			<TitlePartRubric text="Ajouter un sous-titre : " />
			<Input
				required={false}
				placeholder="Mon sous-titre"
				name="subTitle"
				bind:value={valueSubTitle}
			/>
		</div>

		<!-- content -->
		<div class="mt-8">
			<TitlePartRubric text="Contenu de l'article : " />
			<Textarea bind:value={valueContent} placeholder="Text de l'article" />
		</div>

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
