<script>
	import { goto } from '$app/navigation';
	import { connexionService } from '$lib/models/connexion/connexion.service';
	import LogoDisconnect from '$lib/models/logo/components/logo-disconnect.svelte';

	export let addStyleDiv = '';
</script>

<button
	on:click={() => {
		connexionService.resetCurrentLogin();
		goto('/connexion');
	}}
	class="class={`transition-all duration-300 shadow-lg cursor-pointer w-fit h-fit p-2 rounded-full bg-white text-gray-400 ${addStyleDiv} hover:shadow-2xl hover:text-colorone md:p-2 lg:p-3 dark:hover:text-colorone`}"
>
	<LogoDisconnect />
</button>
