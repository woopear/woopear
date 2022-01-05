<script lang="ts">
	import { goto } from '$app/navigation';
	import { infoBulleService } from '$lib/models/info-bulle/info-bulle.service';
	import { EInfoBulleLogo } from '$lib/models/info-bulle/types/info-bulle.enum';
	import LogoHome from '$lib/models/logo/components/logo-home.svelte';

	export let addStyleDiv = '';

	// entrer de la souris sur le logo
	const mouseEnterDiv = (e: MouseEvent): void => {
		infoBulleService.setInfoBubbleText(EInfoBulleLogo.HOME);
		infoBulleService.definePositionXInfoBubbleText(e, window.innerWidth);
		infoBulleService.definePositionYInfoBubbleText(e);
	};

	// sortie de la souris du logo
	const mouseOutDiv = (): void => {
		infoBulleService.setInfoBubbleText('');
		infoBulleService.resetXAndYInfoBubbleText();
	};
</script>

<button
	on:mouseenter={mouseEnterDiv}
	on:mouseleave={mouseOutDiv}
	on:click={() => goto('/')}
	class="class={`transition-all duration-300 shadow-lg cursor-pointer w-fit h-fit p-2 rounded-full bg-white text-gray-400 ${addStyleDiv} hover:shadow-2xl hover:text-colorone md:p-2 lg:p-3 dark:hover:text-colorone`}"
>
	<LogoHome />
</button>
