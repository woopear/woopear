<script lang="ts">
	import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
	import { EBtnBgColorAction, EBtnSizeAction } from '$lib/models/btn-action/types/btn-action.enum';
	import Input from '$lib/models/input/components/input.svelte';
	import { forgotPasswordService } from '../forgot-password.service';
	import { forgotPasswordStore } from '../stores/forgot-password.store';
</script>

{#if $forgotPasswordStore.forgotPassword}
	<section
		class="bg-gray-900/80 absolute t-0 l-0 w-full h-full flex justify-center items-center z-50 px-4"
	>
		<div class="bg-fondPrincipalClaire p-6 dark:bg-fondSecondaireDark dark:text-white">
			<h2 class="font-bold text-lg lg:text-2xl">Vous avez des difficultés à vous connecter ?</h2>
			<h4 class="font-thin text-sm mb-6 lg:text-lg">
				Saisissez votre identifiant Woopear pour commencer :
			</h4>
			<form>
				<Input placeholder="Votre email associé à woopear" />
				<p class="font-thin text-xs mb-8 mt-2">
					Si vous avez oublié quel email est associé, contacter woopear
				</p>
				<div class="text-right">
					<BtnAction
						typeBtn={EBtnBgColorAction.WARRNING}
						sizeBtn={EBtnSizeAction.SMALL}
						textBtn="Annuler"
						handlerClick={forgotPasswordService.disableForgotPassword}
						addStyle="mr-2"
					/>
					<BtnAction
						typeBtn={EBtnBgColorAction.VALIDATE}
						sizeBtn={EBtnSizeAction.SMALL}
						textBtn="Continuer"
						handlerClick={undefined}
					/>
				</div>
			</form>
		</div>
	</section>
{/if}
