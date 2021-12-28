<script lang="ts">
	import { onMount } from 'svelte';
	import { footerService } from '$lib/models/footer/footer.service';
	import { footerStore } from '../stores/footer.store';

	onMount(async () => {
		// recupere le footer
		await footerService.getFooter();
	});
</script>

{#if 'copyright' in $footerStore.footer}
	<footer class="flex-none px-4 py-6 border-t border-gray-300">
		<!-- text de recap presentation -->
		<!-- text de contact -->
		<!-- menu footer -->
		<!-- copyright -->
		<section>
			<p class="text-center">{$footerStore.footer.copyright} {new Date().getFullYear()}</p>
		</section>
	</footer>
{/if}
