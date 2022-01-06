<script lang="ts">
	import BoxRubricColor from '$lib/models/box-rubric/components/box-rubric-color.svelte';
	import BoxRubric from '$lib/models/box-rubric/components/box-rubric.svelte';
	import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
	import { EBtnBgColorAction, EBtnSizeAction } from '$lib/models/btn-action/types/btn-action.enum';
	import Input from '$lib/models/input/components/input.svelte';
	import SubTitleRubric from '$lib/models/sub-title-rubric/components/sub-title-rubric.svelte';
	import TextContentRubric from '$lib/models/text-content-rubric/components/text-content-rubric.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
	import { formProvider } from '$lib/providers/form/form.service';
	import { presentationService } from '../presentation.service';
	import { presentationQuery } from '../queries/presentation.query';
	import { presentationApi } from '../stores/presentation.api';
	import { presentationMutation } from '../stores/presentation.mutation';
	import type { IPresentation } from '../types/presentation.type';

	export let presentation: IPresentation;

	// fonction pour modifier la presentation
	async function updatePresentation(e) {
		// creation du formdata
		const data: IPresentation = formProvider.createFormData(e.target);
		console.log('data', data);

		// modifier la presentation
		await presentationService.updatePresentation(data);
		console.log('presentation', presentation);
	}
</script>

{#if presentation && 'id' in presentation}
	<!-- partie public -->
	<BoxRubricColor color="bg-[#DCFFD6] dark:bg-[#062900] transition-all duration-300">
		<section id="woopear" class="py-12 md:py-16 lg:flex lg:items-start lg:justify-center lg:mt-8">
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
		<form
			on:submit|preventDefault={updatePresentation}
			class="mt-12 lg:mt-24 mb-32 flex justify-center"
		>
			<BoxRubric
				addStyle="shadow-lg flex flex-col items-center"
				addStyleDiv="w-11/12 sm:w-7/12 lg:w-9/12 xl:w-7/12"
				padding="p-6 lg:p-24"
			>
				<div>
					<h3>titre</h3>
					<Input value={presentation.title} addDiv="flex" required name="title" />
				</div>
				<div>
					<h3>sous-titre</h3>
					<Input value={presentation.subTitle} addDiv="flex" required name="subTitle" />
				</div>
				<div>
					<h3>description</h3>

					<textarea
						bind:value={presentation.description}
						required
						name="description"
						rows="5"
						placeholder="ici le text de la présentation"
						class="transition-all duration-300 w-full border-2 border-gray-300 py-2 px-4 rounded-lg focus:outline-none focus:border-colorone dark:bg-fondSecondaireDark"
					/>
				</div>
				<div>
					<BtnAction
						textBtn="Modifier"
						handlerClick={undefined}
						typeBtn={EBtnBgColorAction.VALIDATE}
						sizeBtn={EBtnSizeAction.MEDIUM}
					/>
				</div>
			</BoxRubric>
		</form>
	</BoxRubricColor>
{:else if presentation && 'id' in presentation}
	<!-- partie admin -->
{/if}
