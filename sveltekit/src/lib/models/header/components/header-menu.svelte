<script lang="ts">
	import { page } from '$app/stores';
	import LogoWoopear from '$lib/models/logo/components/logo-woopear.svelte';

	// props design
	export let styleDiv: string;
	export let addStyleNav: string;

	// fonction click menu sandwich
	export let handlerClickMenuSandwich;

	// liste des paths où le menu n'apparait pas
	let pathsMenu = ['/connexion', '/forgot-password'];
	let pathMenuPrincipal = ['/'];
	let pathMenuDashboard = ['/dashboard'];
</script>

<!-- menu sandwich -->
{#if !pathsMenu.includes($page.path)}
	<div class="flex justify-between w-full items-center md:hidden">
		<!-- barre du menu -->
		<div on:click={handlerClickMenuSandwich} class={styleDiv}>
			<div
				class="bg-fondPrincipalDark absolute rounded-full w-8 h-1 top-4 left-2 dark:bg-fondPrincipalClaire"
			/>
			<div
				class="bg-fondPrincipalDark absolute rounded-full w-8 h-1 top-7 left-2 dark:bg-fondPrincipalClaire"
			/>
		</div>
	</div>
{/if}

<!-- logo woopear -->
<LogoWoopear size="w-10 h-10" />

<!-- contenu du menu -->
{#if !pathsMenu.includes($page.path)}
	<nav
		class={`transition-all duration-300 absolute top-24 ${addStyleNav} w-full min-h-screen md:static md:min-h-min`}
	>
		<ul class="">
			{#if pathMenuPrincipal.includes($page.path)}
				<slot name="menu-principal" />
			{/if}
			{#if pathMenuDashboard.includes($page.path)}
				<slot name="menu-dashboard" />
			{/if}
		</ul>
	</nav>
{/if}

<style>
	.open {
		transition: all 0.6s;
	}
	.open :nth-child(1) {
		top: 22px;
		left: 8px;
		transform: rotate(315deg);
		transition: all 0.6s;
	}
	.open :nth-child(2) {
		top: 22px;
		left: 8px;
		transform: rotate(-315deg);
		transition: all 0.6s;
	}
	.close {
		transition: all 0.6s;
	}
	.close :nth-child(1) {
		transition: all 0.6s;
	}
	.close :nth-child(2) {
		transition: all 0.6s;
	}
</style>
