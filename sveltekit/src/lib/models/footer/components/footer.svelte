<script lang="ts">
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';
	import LogoWoopear from '$lib/models/logo/components/logo-woopear.svelte';
	import NavItemFooter from './nav-item-footer.svelte';
	import type { IFooter } from '../types/footer.type';
	import type { IPresentation } from '$lib/models/presentation/types/presentation.type';
	import type { IContact } from '$lib/models/contact/types/contact.type';

	export let footer: IFooter;
	export let presentation: IPresentation;
	export let contact: IContact;
</script>

<footer
	class="transition-all duration-300 flex-none px-4 py-6 border-t border-gray-300 bg-fondPrincipalClaire text-fondPrincipalDark dark:text-fondPrincipalClaire dark:bg-fondPrincipalDark"
>
	<div class="flex flex-col items-center sm:flex-row-reverse sm:items-start sm:px-8 lg:px-28">
		<!-- menu footer -->
		<nav class="text-xs w-6/12 mb-6 sm:flex sm:flex-col sm:items-end sm:pr-12">
			<ul>
				<NavItemFooter libelle="mentions légales" link="/mentions-legales" />
				<NavItemFooter libelle="cookies" link="#" />
			</ul>
		</nav>
		{#if 'id' in presentation && 'id' in contact}
			<!-- section entreprise + contact -->
			<section class="flex flex-col items-start w-6/12">
				<!-- text de recap presentation -->
				<section class="text-xs mb-6">
					<h1 class="font-bold flex items-center">
						<span class="mr-2">
							<LogoWoopear size="h-4 w-4" />
						</span>
						{filterStringService.firstToUppperCase(presentation.title)}
					</h1>
					<p>{filterStringService.textFormating(presentation.subTitle)}</p>
				</section>
				<!-- text de contact -->
				<section class="text-xs mb-6">
					<h3 class="font-bold">{filterStringService.firstToUppperCase('contact')}</h3>
					<p>{filterStringService.textFormating(contact.address)}</p>
					<p>{filterStringService.textFormating(contact.phoneNumber)}</p>
					<p>{contact.email}</p>
				</section>
			</section>
		{/if}
	</div>
	{#if 'copyright' in footer}
		<!-- copyright -->
		<section class="text-xs">
			<p class="text-center">{footer.copyright} {new Date().getFullYear()}</p>
		</section>
	{/if}
</footer>

<!--
  @component

  ## footer

  > footer du site, contient un menu, une partie contact  
  > un petit mot sur l'entreprise, et un menu  

  ### props

  - RAS

  ### exemple d'utilisation

  ```js
  <Footer />
  ```

  ### fonctions / variables

  ```js
  // dedans on appelle à recuperer
  // footer, contact, présentation
  onMount()
  ```

  ### les imports

  ```js
  	import LogoWoopear from '$lib/models/logo/components/logo-woopear.svelte';
	import NavItemFooter from './nav-item-footer.svelte';
  ```

-->
