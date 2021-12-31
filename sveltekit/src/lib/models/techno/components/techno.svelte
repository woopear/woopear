<script lang="ts">
	import BoxRubricSans from '$lib/models/box-rubric/components/box-rubric-sans.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';
	import { technoStore } from '../stores/techno.store';
	import type { ITechno } from '../types/techno.type';

	export let technos: ITechno[];
</script>

{#if $technoStore.technos.length > 0}
	<BoxRubricSans>
		<TitleRubric title="nos technos" addStyle="text-center mt-12" />
		<section class="scroll flex sm:justify-center mt-10 mb-6 overflow-auto pb-6">
			{#each technos as techno}
				<div class="items-scroll flex flex-nowrap flex-col items-center">
					<div class="flex flex-col items-center w-28">
						<!-- img -->
						<div
							class="rounded-full bg-cover bg-center h-10 w-10"
							style={`background-image: url("${import.meta.env.VITE_URL_API_IMG}${
								techno.image.url
							}");`}
						/>
						<!-- libelle techno -->
						<h3 class="text-sm mt-2">{filterStringService.firstToUppperCase(techno.name)}</h3>
					</div>
				</div>
			{/each}
		</section>
	</BoxRubricSans>
{/if}

<style>
	.scroll {
		-ms-overflow-style: none; /* IE and Edge */
		scrollbar-width: none;
	}

	.scroll::-webkit-scrollbar {
		display: none;
	}

	@media (max-width: 640px) {
		.items-scroll {
			animation: slid 20s infinite linear;
		}

		@keyframes slid {
			0% {
				transform: translateX(100px);
			}
			50% {
				transform: translateX(-350px);
			}
			100% {
				transform: translateX(100px);
			}
		}
	}
</style>
