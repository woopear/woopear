<script lang="ts">
	export let size = 'h-4 w-4';
	export let addStyle = '';
	export let addStyleDiv = '';
	export let handlerClick;
</script>

<div
	on:click={handlerClick}
	class={`rounded-full p-2 hover:bg-gray-200 text-red-500 max-w-fit cursor-pointer ${addStyleDiv}`}
>
	<svg
		xmlns="http://www.w3.org/2000/svg"
		class={`${size} ${addStyle}`}
		fill="none"
		viewBox="0 0 24 24"
		stroke="currentColor"
	>
		<path
			stroke-linecap="round"
			stroke-linejoin="round"
			stroke-width="2"
			d="M6 18L18 6M6 6l12 12"
		/>
	</svg>
</div>
