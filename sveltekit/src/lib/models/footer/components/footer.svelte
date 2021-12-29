<script lang="ts">
	import { onMount } from 'svelte';
	import { footerService } from '$lib/models/footer/footer.service';
	import { footerStore } from '../stores/footer.store';
	import { presentationService } from '$lib/models/presentation/presentation.service';
	import { presentationStore } from '$lib/models/presentation/stores/presentation.store';
	import { contactService } from '$lib/models/contact/contact.service';
	import { contactStore } from '$lib/models/contact/stores/contact.store';
	import LogoWoopear from '$lib/models/logo/components/logo-woopear.svelte';
	import NavItemFooter from './nav-item-footer.svelte';

	onMount(async () => {
		// recupere le footer
		await footerService.getFooter();
		// recupere presentation
		await presentationService.getPresentation();
		// recupere contact
		await contactService.getContact();
	});
</script>

{#if 'copyright' in $footerStore.footer && 'id' in $presentationStore.presentation && 'id' in $contactStore.contact}
	<footer
		class="transition-all duration-300 flex-none px-4 py-6 border-t border-gray-300 bg-fondPrincipalClaire text-fondPrincipalDark dark:text-fondPrincipalClaire dark:bg-fondPrincipalDark"
	>
		<div class="flex flex-col items-center sm:flex-row-reverse sm:items-start sm:px-8 lg:px-24">
			<!-- menu footer -->
			<nav class="text-xs w-6/12 mb-6 sm:flex sm:flex-col sm:items-end sm:pr-12">
				<ul>
					<NavItemFooter libelle="Mentions légales" link="#" />
					<NavItemFooter libelle="Cookies" link="#" />
				</ul>
			</nav>
			<!-- section entreprise + contact -->
			<section class="flex flex-col items-start w-6/12">
				<!-- text de recap presentation -->
				<section class="text-xs mb-6">
					<h1 class="font-bold flex items-center">
						<span class="mr-2">
							<LogoWoopear hPixel="12" wPixel="12" />
						</span>
						{$presentationStore.presentation.title}
					</h1>
					<p>{$presentationStore.presentation.subTitle}</p>
				</section>
				<!-- text de contact -->
				<section class="text-xs mb-6">
					<h3 class="font-bold">contact</h3>
					<p>{$contactStore.contact.address}</p>
					<p>{$contactStore.contact.phoneNumber}</p>
					<p>{$contactStore.contact.email}</p>
				</section>
			</section>
		</div>
		<!-- copyright -->
		<section class="text-xs">
			<p class="text-center">{$footerStore.footer.copyright} {new Date().getFullYear()}</p>
		</section>
	</footer>
{/if}

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
