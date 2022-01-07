<script lang="ts">
	import BtnAction from '$lib/models/btn-action/components/btn-action.svelte';
	import { EBtnBgColorAction, EBtnSizeAction } from '$lib/models/btn-action/types/btn-action.enum';
	import { infoBulleService } from '$lib/models/info-bulle/info-bulle.service';
	import Input from '$lib/models/input/components/input.svelte';
	import { forgotPasswordService } from '../forgot-password.service';
	import { forgotPasswordStore } from '../stores/forgot-password.store';

	let valueEmail = '';
	let event: MouseEvent;

	// recuperation du event click sur le btn pour afficher l'info bulle error à l'endroit du click
	const hanlderClickBtnAction = (e): void => {
		event = e;
	};

	// click btn annuler
	const desactivateModal = () => {
		// reset info bulle
		infoBulleService.resetXAndYInfoBubble();
		infoBulleService.resetXAndYInfoBubbleText();
		infoBulleService.setInfoBubbleText('');
		infoBulleService.setInfoBubbleError('');

		// reset input
		valueEmail = '';

		// femeture de la modal
		forgotPasswordService.disableForgotPassword();
	};
</script>

{#if $forgotPasswordStore.forgotPassword}
	<section
		class="bg-gray-900/80 absolute t-0 l-0 w-full h-full flex justify-center items-center z-40 px-4"
	>
		<div class="bg-fondPrincipalClaire p-6 dark:bg-fondSecondaireDark dark:text-white">
			<h2 class="font-bold text-lg lg:text-2xl">Vous avez des difficultés à vous connecter ?</h2>
			<h4 class="font-thin text-sm mb-6 lg:text-lg">
				Saisissez votre identifiant Woopear pour commencer :
			</h4>
			<form
				on:submit|preventDefault={() => {
					// si valueEmail est renseigné, on envoie l'email
					if (valueEmail !== '') {
						forgotPasswordService.sendMailForgotPassword(valueEmail, event);
						valueEmail = '';
					}
				}}
			>
				<!-- input email -->
				<Input
					placeholder="Votre email associé à woopear"
					required={true}
					bind:value={valueEmail}
					type="email"
				/>
				<p class="font-thin text-xs mb-8 mt-2">
					Si vous avez oublié quel email est associé, contacter woopear
				</p>
				<div class="text-right">
					<!-- btn return -->
					<BtnAction
						typeBtn={EBtnBgColorAction.WARRNING}
						sizeBtn={EBtnSizeAction.SMALL}
						textBtn="Annuler"
						handlerClick={desactivateModal}
						addStyle="mr-2"
					/>
					<!-- btn envoie formulaire -->
					<BtnAction
						typeBtn={EBtnBgColorAction.VALIDATE}
						sizeBtn={EBtnSizeAction.SMALL}
						textBtn="Continuer"
						handlerClick={hanlderClickBtnAction}
					/>
				</div>
			</form>
		</div>
	</section>
{/if}
