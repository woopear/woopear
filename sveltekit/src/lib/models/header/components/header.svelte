<script lang="ts">
	import LogoWoopear from '$lib/models/logo/components/logo-woopear.svelte';
	import NavItem from './nav-item.svelte';
	import { constItemMenuHeader } from '../stores/header.const';
	import { page } from '$app/stores';

	let styleDiv = `group close cursor-pointer h-12 w-12 relative ml-2`;
	let addStyleNav = `-left-full`;

	// affiche / cache le menu
	const clickForSeeMenu = (): void => {
		if (document.querySelector('.open')) {
			styleDiv = `group close cursor-pointer h-12 w-12 relative ml-2`;
			addStyleNav = `-left-full`;
		} else {
			styleDiv = `group close open cursor-pointer h-12 w-12 relative ml-2`;
			addStyleNav = `left-0`;
		}
	};
</script>

<header
	class="transition-all duration-300 shadow-md flex items-center flex-none fixed bg-fondPrincipalClaire pl-2 pr-4 h-24 w-full border-b border-gray-300 md:pl-4 dark:bg-fondPrincipalDark z-30"
>
	<!-- menu sandwich -->
	{#if $page.path === '/'}
		<div class="flex justify-between w-full items-center md:hidden">
			<!-- barre du menu -->
			<div on:click={clickForSeeMenu} class={styleDiv}>
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
	{#if $page.path === '/'}
		<nav
			class={`transition-all duration-300 absolute top-24 ${addStyleNav} w-full min-h-screen md:static md:min-h-min`}
		>
			<ul
				class="px-4 py-4 bg-fondPrincipalClaire min-h-screen md:min-h-min md:bg-transparent md:flex md:flex-row md:p-0 dark:bg-fondPrincipalDark"
			>
				<NavItem
					handlerClickA={clickForSeeMenu}
					libelle={constItemMenuHeader.home.libelle}
					link={constItemMenuHeader.home.path}
				/>
				<NavItem
					handlerClickA={clickForSeeMenu}
					libelle={constItemMenuHeader.service.libelle}
					link={constItemMenuHeader.service.path}
				/>
				<NavItem
					handlerClickA={clickForSeeMenu}
					libelle={constItemMenuHeader.method.libelle}
					link={constItemMenuHeader.method.path}
				/>
				<NavItem
					handlerClickA={clickForSeeMenu}
					libelle={constItemMenuHeader.team.libelle}
					link={constItemMenuHeader.team.path}
				/>
				<NavItem
					handlerClickA={clickForSeeMenu}
					libelle={constItemMenuHeader.product.libelle}
					link={constItemMenuHeader.product.path}
				/>
				<NavItem
					handlerClickA={clickForSeeMenu}
					libelle={constItemMenuHeader.contact.libelle}
					link={constItemMenuHeader.contact.path}
				/>
			</ul>
		</nav>
	{/if}
</header>

<!--
  @component

  ## header

  > header du menu, contient un menu d'encre  
  > afin de ce placer au bon endroit pour  
  > voir le contenu demandé

  ### props

  - RAS

  ### exemple d'utilisation

  ```js
  <Header />
  ```

  ### fonctions / variables

  ```js
  // fonction qui permet d'afficher ou de cacher  
  // le menu en mode mobile ou tablette
  clickForSeeMenu = (): void => 
  ```

  ### les imports

	```js
	import LogoWoopear from '$lib/models/logo/components/logo-woopear.svelte';
	import NavItem from '$lib/models/logo/components/nav-item.svelte';  
	```

-->
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
