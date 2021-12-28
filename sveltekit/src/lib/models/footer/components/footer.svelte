<script lang="ts">
	import { onMount } from 'svelte';
	import { footerService } from '$lib/models/footer/footer.service';
	import { footerStore } from '../stores/footer.store';
	import { presentationService } from '$lib/models/presentation/presentation.service';
	import { presentationStore } from '$lib/models/presentation/stores/presentation.store';

	onMount(async () => {
		// recupere le footer
		await footerService.getFooter();
		// recupere presentation
		await presentationService.getPresentation();
	});
</script>

{#if 'copyright' in $footerStore.footer && 'id' in $presentationStore.presentation}
	<footer class="flex-none px-4 py-6 border-t border-gray-300">
		<!-- text de recap presentation -->
		<section>
			<h1>Wep studio</h1>
			<p>{$presentationStore.presentation.subTitle}</p>
		</section>
		<!-- text de contact -->
		<!-- menu footer -->
		<!-- copyright -->
		<section>
			<p class="text-center">{$footerStore.footer.copyright} {new Date().getFullYear()}</p>
		</section>
	</footer>
{/if}
