<script lang="ts">
	import BoxRubric from '$lib/models/box-rubric/components/box-rubric.svelte';
	import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
	import { EBtnBgColorAction, EBtnSizeAction } from '$lib/models/btn-action/types/btn-action.enum';
	import Input from '$lib/models/input/components/input.svelte';
	import SubTitleRubric from '$lib/models/sub-title-rubric/components/sub-title-rubric.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
	import type { IContact } from '../types/contact.type';
	import { formProvider } from '$lib/providers/form/form.service';
	import { contactService } from '../contact.service';

	export let contact: IContact;

	// send message
	const handlerForm = async (e) => {
		// creation du formdata
		const data = formProvider.createFormData(e.target);
		// on envoie le mail
		await contactService.sendMailContact(data);
	};
</script>

<form class="mt-12 lg:mt-24 mb-32 flex justify-center" on:submit|preventDefault={handlerForm}>
	<BoxRubric
		addStyle="shadow-lg flex flex-col items-center"
		addStyleDiv="w-11/12 sm:w-7/12 lg:w-9/12 xl:w-7/12"
		padding="p-6 lg:p-24"
	>
		<TitleRubric title="Contactez nous !" addStyle="text-center" />
		<SubTitleRubric subTitle={`${contact.info} - ${contact.phoneNumber}`} addStyle="text-center" />
		<p class="mt-6 mb-12">OU</p>
		<Input placeholder="Votre email *" required={true} name="email" />
		<Input addDiv="mt-4 mb-8" placeholder="Votre numéro de téléphone" name="tel" />
		<div class="w-full">
			<textarea
				required
				name="message"
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
