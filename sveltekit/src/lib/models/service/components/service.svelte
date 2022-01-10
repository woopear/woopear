<script lang="ts">
	import BoxRubricColor from '$lib/models/box-rubric/components/box-rubric-color.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';
	import type { IService } from '../types/service.type';

	export let services: IService[];
</script>

{#if services.length > 0}
	<BoxRubricColor
		color="bg-[#ffe8ad] dark:bg-[#523a00] transition-all duration-300"
		addStyleDiv="py-24"
	>
		<section class="pt-8">
			<!-- title service -->
			<TitleRubric title="nos services" addStyle="lg:mb-12 lg:text-center" />
			{#each services as service, index}
				{#if index % 2 === 0}
					<!-- cadre avec l'image à gauche -->
					<section class="py-8 sm:py-12 sm:flex sm:items-start">
						<div
							class="rounded-lg bg-cover bg-center w-full h-40 sm:flex-none sm:w-1/2 sm:mr-12 lg:h-72 xl:h-96"
							style={service.image !== null
								? `background-image: url("${import.meta.env.VITE_URL_API_IMG}${
										service.image.formats.small.url
								  }");`
								: "background-image: url('../../../../../static/image-found.png');"}
						/>
						<div class="sm:flex-1 lg:w-4/12 lg:flex-none">
							<h2 class="text-xl font-bold my-2 lg:text-3xl">
								{filterStringService.firstToUppperCase(service.name)}
							</h2>
							<p class="text-justify lg:text-xl">
								{filterStringService.textFormating(service.description)}
							</p>
						</div>
					</section>
				{:else}
					<!-- cadre avec l'image droite -->
					<section class="py-8 sm:py-12 sm:flex sm:items-start sm:flex-row-reverse">
						<div
							class="rounded-lg bg-cover bg-center w-full h-40 sm:flex-none sm:w-1/2 sm:ml-12 lg:h-72 xl:h-96"
							style={service.image !== null
								? `background-image: url("${import.meta.env.VITE_URL_API_IMG}${
										service.image.formats.small.url
								  }");`
								: "background-image: url('../../../../../static/image-found.png');"}
						/>
						<div class="sm:flex-1 sm:flex sm:flex-col sm:items-end lg:w-4/12 lg:flex-none">
							<h2 class="text-xl font-bold my-2 lg:text-3xl">
								{filterStringService.firstToUppperCase(service.name)}
							</h2>
							<p class="text-justify lg:text-xl">
								{filterStringService.textFormating(service.description)}
							</p>
						</div>
					</section>
				{/if}
			{/each}
		</section>
	</BoxRubricColor>
{/if}
