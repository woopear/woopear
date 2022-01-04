<script lang="ts">
	import BoxRubricSans from '$lib/models/box-rubric/components/box-rubric-sans.svelte';
	import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
	import { EBtnBgColorAction, EBtnSizeAction } from '$lib/models/btn-action/types/btn-action.enum';
	import Input from '$lib/models/input/components/input.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
	import { formProvider } from '$lib/providers/form/form.service';
	import { connexionService } from '$lib/models/connexion/connexion.service';
	import type { IConnextionObject } from '../types/connexion.type';
	import { connexionStore } from '../stores/connexion.store';
	import { goto } from '$app/navigation';

	let valueIdentifier = '';
	let valuePassword = '';

	// connexion user => go vers le dashboard
	const handlerForm = async (e): Promise<void> => {
		// creation du formData
		const formData: IConnextionObject = formProvider.createFormData(e.target);

		// connexion user
		await connexionService.login(formData);

		// efface les inputs
		valueIdentifier = '';
		valuePassword = '';

		// si jwt on va sur dashboard
		if ($connexionStore.currentLogin.jwt) {
			goto('/dashboard');
		}
	};
</script>

<BoxRubricSans addStyleDiv="w-full">
	<!-- title -->
	<TitleRubric title="Identifiants Woopear" addStyle="text-center " />

	<!-- box pour connexion user -->
	<form
		class="flex flex-col m-auto w-72 sm:w-7/12 md:w-5/12 lg:w-4/12 xl:w-3/12"
		on:submit|preventDefault={handlerForm}
	>
		<Input
			placeholder="Email"
			required={true}
			addDiv="mt-12 mb-2"
			name="identifier"
			bind:value={valueIdentifier}
		/>
		<Input placeholder="Mot de passe" required={true} name="password" bind:value={valuePassword} />
		<div class="mt-4 ml-auto">
			<BtnAction
				handlerClick={undefined}
				textBtn="se connecter"
				sizeBtn={EBtnSizeAction.MEDIUM}
				typeBtn={EBtnBgColorAction.VALIDATE}
			/>
		</div>
		<div class="mt-6 mx-auto">
			<p class="text-colorone text-xs border-t pt-4 cursor-pointer hover:underline">
				Mot de passe oublié ?
			</p>
		</div>
	</form>
</BoxRubricSans>
