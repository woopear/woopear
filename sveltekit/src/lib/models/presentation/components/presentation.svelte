<script lang="ts">
	import BoxRubricColor from '$lib/models/box-rubric/components/box-rubric-color.svelte';
	import BoxRubric from '$lib/models/box-rubric/components/box-rubric.svelte';
	import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
	import { EBtnBgColorAction, EBtnSizeAction } from '$lib/models/btn-action/types/btn-action.enum';
	import type { IImage } from '$lib/models/image/types/image.type';
	import InputFile from '$lib/models/input-image/components/input-image.svelte';
	import { inputImageService } from '$lib/models/input-image/inputFile.service';
	import Input from '$lib/models/input/components/input.svelte';
	import SubTitleRubric from '$lib/models/sub-title-rubric/components/sub-title-rubric.svelte';
	import TextContentRubric from '$lib/models/text-content-rubric/components/text-content-rubric.svelte';
	import Textarea from '$lib/models/textarea/components/textarea.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
	import { userStore } from '$lib/models/users/stores/user.store';
	import { formProvider } from '$lib/providers/form/form.service';
	import { presentationService } from '../presentation.service';
	import type { IPresentation } from '../types/presentation.type';

	export let presentation: IPresentation;
	let event: MouseEvent;
	let image;

	// recuperation du event click sur le btn pour afficher l'info bulle error à l'endroit du click
	const hanlderClickBtnAction = (e): void => {
		event = e;
	};

	const changeInputFile = (e) => {
		image = e.target.files[0];
	};

	// fonction pour modifier la presentation
	const UpdatePresentation = async (e) => {
		// creation du formdata
		await inputImageService.createImage(e, image);
		// modifier la presentation
		// await presentationService.updatePresentation(data, event);
	};
</script>

{#if (presentation && $userStore.userCurrent.role.name != 'Root') || (presentation && $userStore.userCurrent === null)}
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
{:else if presentation && $userStore.userCurrent.role.name === 'Root'}
	<!-- partie admin -->
	<BoxRubricColor
		color="bg-[#DCFFD6] dark:bg-[#062900] transition-all duration-300"
		addStyleDiv="py-24"
	>
		<form
			on:submit|preventDefault={UpdatePresentation}
			class="mt-12 lg:mt-24 mb-32 flex justify-center"
		>
			<BoxRubric
				addStyle="shadow-lg flex flex-col items-center"
				addStyleDiv="w-11/12 sm:w-7/12 lg:w-9/12 xl:w-7/12"
				padding="p-6 lg:p-24"
			>
				<div>
					<h3>titre</h3>
					<Input value={presentation.title} required name="title" />
				</div>
				<div>
					<h3>sous-titre</h3>
					<Input value={presentation.subTitle} required name="subTitle" />
				</div>
				<div>
					<h3>description</h3>

					<Textarea
						bind:value={presentation.description}
						required
						name="description"
						rows="5"
						placeholder="ici le text de la présentation"
					/>
				</div>
				<div>
					<input type="file" on:change={changeInputFile} />
					<InputFile name="image" />
					<div />
					<div>
						<div>
							<BtnAction
								textBtn="Modifier"
								handlerClick={hanlderClickBtnAction}
								typeBtn={EBtnBgColorAction.VALIDATE}
								sizeBtn={EBtnSizeAction.MEDIUM}
							/>
						</div>
					</div>
				</div>
			</BoxRubric>
		</form>
	</BoxRubricColor>
{/if}
