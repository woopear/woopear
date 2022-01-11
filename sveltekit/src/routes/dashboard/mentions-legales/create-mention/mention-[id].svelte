<script lang="ts">
	import { goto } from '$app/navigation';
	import { page } from '$app/stores';
	import MentionLegaleUpdate from '$lib/models/mention-legale/components/mention-legale-update.svelte';
	import { mentionLegaleStore } from '$lib/models/mention-legale/stores/mention-legale.store';
	import type { IMention } from '$lib/models/mention-legale/types/mention-legale.type';
	import { beforeUpdate } from 'svelte';

	let loader = true;
	let idMention: string;
	let mention: IMention;

	beforeUpdate(() => {
		// si pas de code dans l'url on retourne sur l'accueil
		if (!$page.params['id']) {
			goto('/');
			return;
		}

		// on affecte le query id au idMention
		idMention = $page.params['id'];

		// on recupere la mention grace à son a id
		mention = $mentionLegaleStore.mentionLegales.find((el) => el.id === idMention);

		loader = false;
	});
</script>

<MentionLegaleUpdate {mention} />
