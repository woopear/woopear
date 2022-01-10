<script lang="ts">
	import { goto } from '$app/navigation';
	import { connexionService } from '$lib/models/connexion/connexion.service';
	import { connexionStore } from '$lib/models/connexion/stores/connexion.store';
	import { infoBulleService } from '$lib/models/info-bulle/info-bulle.service';
	import { onMount } from 'svelte';
	import Loader from '$lib/models/loader/components/loader.svelte';
	import MentionLegaleList from '$lib/models/mention-legale/components/mention-legale-list.svelte';
	import { mentionLegaleService } from '$lib/models/mention-legale/mention-legale.service';
	import ArticleMentionList from '$lib/models/article-mention/components/article-mention-list.svelte';
	import { articleMentionService } from '$lib/models/article-mention/article-mention.service';

	let loader = true;

	onMount(async () => {
		// reset info bulle
		infoBulleService.resetXAndYInfoBubble();
		infoBulleService.resetXAndYInfoBubbleText();
		infoBulleService.setInfoBubbleText('');
		infoBulleService.setInfoBubbleError('');

		// si pas de jwt, deconnexion et retour page connexion
		if (!$connexionStore.currentLogin.user) {
			connexionService.resetCurrentLogin();
			goto('/connexion');
			return;
		}

		// recupere les mention legale
		await mentionLegaleService.getAllMentionLegale();

		// recupere les article mention
		await articleMentionService.getAllArticleMentions();

		loader = false;
	});
</script>

<!-- head -->
<svelte:head>
	<title>Utilisateur | Mentions légales</title>
</svelte:head>

{#if loader}
	<Loader />
{:else}
	<div class="mb-12">
		<MentionLegaleList />
		<ArticleMentionList />
	</div>
{/if}
