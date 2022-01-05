<script lang="ts">
	import LogoEyeOpenClose from '$lib/models/logo/components/logo-eye-open-close.svelte';

	export let required = false;
	export let password = false;
	export let value = '';
	export let addDiv = '';
	let openClose = false;

	// affiche / cache le mot de passe
	const changeViewPassword = (): void => {
		openClose = !openClose;
		if ($$restProps.type === 'password') {
			$$restProps.type = 'text';
		} else {
			$$restProps.type = 'password';
		}
		console.log($$restProps);

		setTimeout(() => {
			if ($$restProps.type !== 'password') {
				$$restProps.type = 'password';
				openClose = !openClose;
			}
		}, 5000);
	};
</script>

{#if required && password}
	<div class={`w-full relative ${addDiv}`}>
		<input
			required
			{...$$restProps}
			bind:value
			class="pl-2 pr-10 transition-all duration-300 w-full border-2 bg-transparent border-gray-300 py-2 rounded-lg focus:outline-none focus:border-colorone dark:bg-fondSecondaireDark"
		/>
		<div class="absolute right-4 top-3.5 cursor-pointer" on:click={changeViewPassword}>
			<LogoEyeOpenClose {openClose} size="h-4 w-4" />
		</div>
	</div>
{:else if required}
	<div class={`w-full ${addDiv}`}>
		<input
			required
			{...$$restProps}
			bind:value
			class="transition-all duration-300 w-full border-2 bg-transparent border-gray-300 py-2 px-4 rounded-lg focus:outline-none focus:border-colorone dark:bg-fondSecondaireDark"
		/>
	</div>
{:else}
	<div class={`w-full ${addDiv}`}>
		<input
			{...$$restProps}
			bind:value
			class="transition-all duration-300 w-full border-2 bg-transparent border-gray-300 py-2 px-4 rounded-lg focus:outline-none focus:border-colorone dark:bg-fondSecondaireDark"
		/>
	</div>
{/if}
