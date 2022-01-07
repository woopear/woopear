<script lang="ts">
	import Loader from '$lib/models/loader/components/loader.svelte';
	import { goto } from '$app/navigation';
	import { page } from '$app/stores';
	import { beforeUpdate } from 'svelte';
	import ForgotPasswordPageNewPassword from '$lib/models/forgot-password/components/forgot-password-page-new-password.svelte';

	let loader = true;
	let code;

	beforeUpdate(() => {
		// si pas de code dans l'url on retourne sur l'accueil
		if (!$page.query.get('code')) {
			goto('/');
			return;
		}

		code = $page.query.get('code');
		loader = false;
	});
</script>

{#if loader}
	<Loader />
{:else}
	<div class="flex flex-1 items-center justify-center">
		<ForgotPasswordPageNewPassword {code} />
	</div>
{/if}
