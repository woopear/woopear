<script lang="ts">
	import { goto } from '$app/navigation';
	import BoxRubricSans from '$lib/models/box-rubric/components/box-rubric-sans.svelte';
	import BoxRubric from '$lib/models/box-rubric/components/box-rubric.svelte';
	import BtnLinkText from '$lib/models/btn-link-text/components/btn-link-text.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';
	import type { IProduct } from '../types/product.type';

	export let products: IProduct[];
</script>

{#if products.length > 0}
	<BoxRubricSans>
		<TitleRubric title="Nos réalisations" addStyle="text-center mt-12" />
		<div class="mt-12 md:flex md:flex-wrap md:justify-evenly md:items-stretch lg:mt-24">
			{#each products as product}
				<BoxRubric padding="p-0" addStyleDiv="mb-6 md:w-5/12" addStyle="h-full">
					<section>
						<div
							class="rounded-t-3xl bg-cover bg-center w-full h-40 sm:flex-none lg:h-72 xl:h-96"
							style={`background-image: url("${import.meta.env.VITE_URL_API_IMG}${
								product.image.formats.small.url
							}");`}
						/>
						<div class="p-4 xl:p-8">
							<div class="flex justify-between items-center px-2 pt-2 pb-4">
								<h2 class="font-bold lg:text-3xl">
									{filterStringService.firstToUppperCase(product.name)}
								</h2>
								<BtnLinkText textBtn="Voir le site" myClick={() => goto(`${product.urlLink}`)} />
							</div>
							<h4 class="font-thin pl-4 pb-4 lg:text-lg">
								{filterStringService.firstToUppperCase(product.type)}
							</h4>
							<p class="px-4 text-justify pb-4 lg:text-lg">
								{filterStringService.textFormating(product.description)}
							</p>
						</div>
					</section>
				</BoxRubric>
			{/each}
		</div>
	</BoxRubricSans>
{/if}
