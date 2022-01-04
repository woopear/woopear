<script lang="ts">
	export let wPixel = '52';
	export let hPixel = '32';
	export let addStyleDiv = '';
</script>

<div class={`${addStyleDiv}`}>
	<svg
		class="barre-blue"
		xmlns="http://www.w3.org/2000/svg"
		width={wPixel}
		height={hPixel}
		viewBox="0 0 1007 862"
		fill="none"
	>
		<path
			d="M545 35.1045L651.481 428.909"
			stroke="#0076E3"
			stroke-width="70"
			stroke-linecap="round"
		/>
		<path
			class="barre-violet"
			d="M651 427.104L757.481 820.909"
			stroke="#0076E3"
			stroke-width="70"
			stroke-linecap="round"
		/>
		<path
			d="M971.481 38.1045L865 431.909"
			stroke="#D427FF"
			stroke-width="70"
			stroke-linecap="round"
		/>
		<path
			class="barre-violet"
			d="M865.481 430.104L759 823.909"
			stroke="#D427FF"
			stroke-width="70"
			stroke-linecap="round"
		/>
		<path
			d="M36 74.2852L151.624 501.901"
			stroke="#1DD100"
			stroke-width="70"
			stroke-linecap="round"
		/>
		<path
			class="barre-violet"
			d="M156.608 517.779L239.592 824.68"
			stroke="#1DD100"
			stroke-width="70"
			stroke-linecap="round"
		/>
		<path
			d="M459.643 224.303L350.38 522.859"
			stroke="#FFD600"
			stroke-width="70"
			stroke-linecap="round"
		/>
		<path
			class="barre-violet"
			d="M348.876 527.492L239.613 826.048"
			stroke="#FFD600"
			stroke-width="70"
			stroke-linecap="round"
		/>
	</svg>
</div>

<style>
	.barre-blue {
		animation: test 3s infinite linear;
	}

	.barre-violet {
		animation: test2 2s infinite linear;
	}

	@keyframes test {
		0% {
			transform: rotate(0deg);
		}
		20% {
			transform: rotate(0deg);
		}

		50% {
			transform: rotate(360deg);
		}
		100% {
			transform: rotate(0deg);
		}
	}

	@keyframes test2 {
		0% {
			transform-origin: center;
			transform: rotate(0deg);
		}
		20% {
			transform: rotate(0deg);
		}

		50% {
			transform-origin: center;
			transform: rotate(-360deg);
		}
		100% {
			transform-origin: center;
			transform: rotate(0deg);
		}
	}
</style>
