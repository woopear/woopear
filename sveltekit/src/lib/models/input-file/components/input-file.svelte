<script lang="ts">
	import type { IImage } from '$lib/models/image/types/image.type';

	export let required = false;
	export let addDiv = '';
	export let value = '';
	let avatar: any;
	let fileInput: any;

	const onFileSelected = (e) => {
		let image = e.target.files[0];
		let reader = new FileReader();
		reader.readAsDataURL(image);
		reader.onload = (e) => {
			avatar = e.target.result;
		};
	};
</script>

{#if required}
	<div class={`w-full ${addDiv}`}>
		<input
			bind:value
			type="file"
			alt=""
			required
			{...$$restProps}
			bind:this={fileInput}
			accept=".jpg, .jpeg, .png"
			class="transition-all duration-300 w-full border-2 bg-transparent border-gray-300 py-2 px-4 rounded-lg focus:outline-none focus:border-colorone dark:bg-fondSecondaireDark"
			on:change={(e) => onFileSelected(e)}
		/>
	</div>
{:else}
	<div class={`w-full ${addDiv}`}>
		<input
			bind:value
			type="file"
			alt=""
			{...$$restProps}
			bind:this={fileInput}
			accept=".jpg, .jpeg, .png"
			class="transition-all duration-300 w-full border-2 bg-transparent border-gray-300 py-2 px-4 rounded-lg focus:outline-none focus:border-colorone dark:bg-fondSecondaireDark"
			on:change={(e) => onFileSelected(e)}
		/>
	</div>
{/if}
