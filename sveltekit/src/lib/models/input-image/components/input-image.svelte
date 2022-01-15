<script lang="ts">
	export let required = false;
	export let addDiv = '';
</script>

{#if required}
	<div class={`w-full ${addDiv}`}>
		<input
			type="file"
			required
			{...$$restProps}
			class="transition-all duration-300 w-full border-2 bg-transparent border-gray-300 py-2 px-4 rounded-lg focus:outline-none focus:border-colorone dark:bg-fondSecondaireDark"
		/>
	</div>
{:else}
	<div class={`w-full ${addDiv}`}>
		<input
			type="file"
			alt=""
			{...$$restProps}
			accept=".jpg, .jpeg, .png"
			class="transition-all duration-300 w-full border-2 bg-transparent border-gray-300 py-2 px-4 rounded-lg focus:outline-none focus:border-colorone dark:bg-fondSecondaireDark"
		/>
	</div>
{/if}
