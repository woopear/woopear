<script lang="ts">
	import BoxRubricColor from '$lib/models/box-rubric/components/box-rubric-color.svelte';
	import BoxRubric from '$lib/models/box-rubric/components/box-rubric.svelte';
	import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
	import { EBtnBgColorAction, EBtnSizeAction } from '$lib/models/btn-action/types/btn-action.enum';
	import SubTitleRubric from '$lib/models/sub-title-rubric/components/sub-title-rubric.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
	import type { IContact } from '../types/contact.type';

	export let contact: IContact;
</script>

<form
	class="mt-12 lg:mt-24 mb-32 flex justify-center"
	on:submit|preventDefault={() => console.log('coucou')}
>
	<BoxRubric
		addStyle="shadow-lg flex flex-col items-center"
		addStyleDiv="w-11/12 sm:w-7/12 lg:w-9/12 xl:w-7/12"
		padding="p-6 lg:p-24"
	>
		<TitleRubric title="Contactez nous !" addStyle="text-center" />
		<SubTitleRubric subTitle={`${contact.info} - ${contact.phoneNumber}`} addStyle="text-center" />
		<p class="mt-6 mb-12">OU</p>
		<div class="w-full">
			<input
				required
				placeholder="Votre émail *"
				class="transition-all duration-300 w-full border-2 border-gray-300 py-2 px-4 rounded-lg focus:outline-none focus:border-colorone dark:bg-fondSecondaireDark"
			/>
		</div>
		<div class="mt-4 mb-8 w-full">
			<input
				placeholder="Votre numéro de téléphone"
				class="transition-all duration-300 w-full border-2 border-gray-300 py-2 px-4 rounded-lg focus:outline-none focus:border-colorone dark:bg-fondSecondaireDark"
			/>
		</div>
		<div class="w-full">
			<textarea
				required
				rows="5"
				placeholder="Donnez nous des informations sur votre projet *"
				class="transition-all duration-300 w-full border-2 border-gray-300 py-2 px-4 rounded-lg focus:outline-none focus:border-colorone dark:bg-fondSecondaireDark"
			/>
		</div>
		<div class="ml-auto mt-4">
			<BtnAction
				textBtn="Envoyer"
				handlerClick={undefined}
				typeBtn={EBtnBgColorAction.VALIDATE}
				sizeBtn={EBtnSizeAction.MEDIUM}
			/>
		</div>
	</BoxRubric>
</form>
