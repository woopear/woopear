<script lang="ts">
	export let required = false;
	export let value = '';
	export let addDiv = '';
</script>

{#if required}
	<div class={`w-full ${addDiv}`}>
		<input
			required
			{...$$restProps}
			bind:value
			class="transition-all duration-300 w-full border-2 border-gray-300 py-2 px-4 rounded-lg focus:outline-none focus:border-colorone dark:bg-fondSecondaireDark"
		/>
	</div>
{:else}
	<div class={`w-full ${addDiv}`}>
		<input
			{...$$restProps}
			bind:value
			class="transition-all duration-300 w-full border-2 border-gray-300 py-2 px-4 rounded-lg focus:outline-none focus:border-colorone dark:bg-fondSecondaireDark"
		/>
	</div>
{/if}
