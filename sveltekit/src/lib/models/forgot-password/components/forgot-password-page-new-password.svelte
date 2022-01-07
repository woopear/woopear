<script lang="ts">
	import { goto } from '$app/navigation';

	import BoxRubricSans from '$lib/models/box-rubric/components/box-rubric-sans.svelte';
	import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
	import { EBtnBgColorAction, EBtnSizeAction } from '$lib/models/btn-action/types/btn-action.enum';
	import { connexionStore } from '$lib/models/connexion/stores/connexion.store';
	import Input from '$lib/models/input/components/input.svelte';
	import SubTitleRubric from '$lib/models/sub-title-rubric/components/sub-title-rubric.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
	import { formProvider } from '$lib/providers/form/form.service';
	import { forgotPasswordService } from '../forgot-password.service';
	import type { IForgotPasswordObjectRequest } from '../types/forgot-password.type';

	export let code;
	let valueNewPassword = '';
	let valueConfirmedNewPassword = '';
	let event: MouseEvent;

	// recuperation du event click sur le btn pour afficher l'info bulle error à l'endroit du click
	const hanlderClickBtnAction = (e): void => {
		event = e;
	};

	// envoie du formulaire
	const handlerForm = async (e): Promise<void> => {
		// creation formData
		const formData = formProvider.createFormData<IForgotPasswordObjectRequest>(e.target);
		// on ajoute le code reçus dans l'url dans l'objet data pour la request (ce code viens du mail)
		formData.code = code;

		// envoie new mot de passe
		await forgotPasswordService.updatePassword(formData, event);

		// reset valeur input
		valueNewPassword = '';
		valueConfirmedNewPassword = '';

		// si jwt on va sur dashboard
		if ($connexionStore.currentLogin.jwt) {
			goto('/dashboard');
		}
	};
</script>

<BoxRubricSans addStyleDiv="w-full">
	<!-- title -->
	<TitleRubric title="Nouveau mot de passe" addStyle="text-center " />
	<SubTitleRubric
		addStyle="text-center mx-auto max-w-xl mt-2"
		subTitle="Vous avez fait une demande de mot de passe oublié, enregistrer un nouveau mot de passe à l'aide du formulaire."
	/>

	<!-- box pour connexion user -->
	<form
		class="flex flex-col m-auto w-72 sm:w-7/12 md:w-5/12 lg:w-4/12 xl:w-3/12"
		on:submit|preventDefault={handlerForm}
	>
		<Input
			placeholder="Mot de passe"
			type="password"
			password={true}
			required={true}
			addDiv="mt-8 mb-2"
			name="password"
			bind:value={valueNewPassword}
		/>
		<Input
			placeholder="Confirmer le mot de passe"
			type="password"
			password={true}
			required={true}
			name="passwordConfirmation"
			bind:value={valueConfirmedNewPassword}
		/>
		<div class="mt-4 ml-auto">
			<BtnAction
				handlerClick={hanlderClickBtnAction}
				textBtn="Valider"
				sizeBtn={EBtnSizeAction.MEDIUM}
				typeBtn={EBtnBgColorAction.VALIDATE}
			/>
		</div>
	</form>
</BoxRubricSans>
