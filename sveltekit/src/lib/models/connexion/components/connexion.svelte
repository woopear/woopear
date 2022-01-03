<script lang="ts">
	import BoxRubricSans from '$lib/models/box-rubric/components/box-rubric-sans.svelte';
	import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
	import { EBtnBgColorAction, EBtnSizeAction } from '$lib/models/btn-action/types/btn-action.enum';
	import Input from '$lib/models/input/components/input.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
</script>

<BoxRubricSans addStyleDiv="w-full">
	<!-- title -->
	<TitleRubric title="Identifiants Woopear" addStyle="text-center " />

	<!-- box pour connexion user -->
	<form class="flex flex-col m-auto w-72 sm:w-7/12 md:w-5/12 lg:w-4/12 xl:w-3/12">
		<Input placeholder="Email" required={true} addDiv="mt-12 mb-4" />
		<Input placeholder="Mot de passe" required={true} />
		<div class="mt-4 ml-auto">
			<BtnAction
				handlerClick={undefined}
				textBtn="se connecter"
				sizeBtn={EBtnSizeAction.MEDIUM}
				typeBtn={EBtnBgColorAction.VALIDATE}
			/>
		</div>
	</form>
</BoxRubricSans>
