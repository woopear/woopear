<script lang="ts">
	import NavItem from './nav-item.svelte';
	import { constItemMenuDashbord, constItemMenuHeader } from '../stores/header.const';
	import HeaderMenu from './header-menu.svelte';
	import { connexionStore } from '$lib/models/connexion/stores/connexion.store';

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
	<HeaderMenu handlerClickMenuSandwich={clickForSeeMenu} {styleDiv} {addStyleNav}>
		<!-- menu principal -->
		<div
			slot="menu-principal"
			class="px-4 py-4 bg-fondPrincipalClaire min-h-screen md:min-h-min md:bg-transparent md:flex md:flex-row md:p-0 dark:bg-fondPrincipalDark"
		>
			<NavItem
				handlerClickA={clickForSeeMenu}
				libelle={constItemMenuHeader.home.libelle}
				link={constItemMenuHeader.home.path}
			/>
			<NavItem
				handlerClickA={clickForSeeMenu}
				libelle={constItemMenuHeader.method.libelle}
				link={constItemMenuHeader.method.path}
			/>
			<NavItem
				handlerClickA={clickForSeeMenu}
				libelle={constItemMenuHeader.service.libelle}
				link={constItemMenuHeader.service.path}
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
		</div>

		<!-- menu dashboard -->
		<div
			slot="menu-dashboard"
			class="px-4 py-4 bg-fondPrincipalClaire min-h-screen md:min-h-min md:bg-transparent md:flex md:flex-row md:p-0 dark:bg-fondPrincipalDark"
		>
			{#if $connexionStore.currentLogin.user}
				{#if $connexionStore.currentLogin.user.role.type === 'root'}
					<NavItem
						handlerClickA={clickForSeeMenu}
						libelle={constItemMenuDashbord.mentionlegales.libelle}
						link={constItemMenuDashbord.mentionlegales.path}
					/>
				{/if}
			{/if}
		</div>
	</HeaderMenu>
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
