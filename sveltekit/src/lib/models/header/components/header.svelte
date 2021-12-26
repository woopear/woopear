<script lang="ts">
	import LogoWoopear from '$lib/models/logo/components/logo-woopear.svelte';
	import NavItem from './nav-item.svelte';

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
	class="flex items-center flex-none fixed bg-fondPrincipalClaire pl-2 pr-4 h-24 w-full border-b border-gray-300 md:pl-4"
>
	<!-- menu sandwich -->
	<div class="flex justify-between w-full items-center md:hidden">
		<!-- barre du menu -->
		<div on:click={clickForSeeMenu} class={styleDiv}>
			<div class="bg-fondPrincipalDark absolute rounded-full w-8 h-1 top-4 left-2" />
			<div class="bg-fondPrincipalDark absolute rounded-full w-8 h-1 top-7 left-2" />
		</div>
	</div>

	<!-- logo woopear -->
	<LogoWoopear />

	<!-- contenu du menu -->
	<nav
		class={`transition-all duration-300 absolute top-24 ${addStyleNav} w-full min-h-screen md:static md:min-h-min`}
	>
		<ul
			class="px-4 py-4 bg-fondPrincipalClaire min-h-screen md:min-h-min md:bg-transparent md:flex md:flex-row md:p-0"
		>
			<NavItem libelle="Woopear" link="#coucou" />
			<NavItem libelle="Services" link="#coucou" />
			<NavItem libelle="Methode" link="#coucou" />
			<NavItem libelle="Equipe" link="#coucou" />
			<NavItem libelle="Réalisations" link="#coucou" />
			<NavItem libelle="Contact" link="#coucou" />
		</ul>
	</nav>
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
