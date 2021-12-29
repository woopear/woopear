<script lang="ts">
	import BoxRubricSans from '$lib/models/box-rubric/components/box-rubric-sans.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
	import type { IMethod } from '../types/method.type';

	export let method: IMethod;
</script>

{#if method && 'id' in method}
	<!-- partie public -->
	<BoxRubricSans>
		<section>
			<TitleRubric title={method.title} />
		</section>
	</BoxRubricSans>
{:else if method && 'id' in method}
	<!-- partie admin -->
{/if}
