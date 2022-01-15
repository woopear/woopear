<script lang="ts">
	import { goto } from '$app/navigation';
	import { page } from '$app/stores';
	import ArticleMentionUpdate from '$lib/models/article-mention/components/article-mention-update.svelte';
	import { articleMentionStore } from '$lib/models/article-mention/stores/article-mention.store';
	import type { IArticleMention } from '$lib/models/article-mention/types/article-mention.type';
	import { beforeUpdate } from 'svelte';

	let loader = true;
	let idArticleMention: string;
	let articleMention: IArticleMention;

	beforeUpdate(() => {
		// si pas de code dans l'url on retourne sur l'accueil
		if (!$page.params['id']) {
			goto('/');
			return;
		}

		// on affecte le query id au idArticleMention
		idArticleMention = $page.params['id'];

		// on recupere l'articleMention grace à son a id
		articleMention = $articleMentionStore.articleMentions.find((el) => el.id === idArticleMention);

		loader = false;
	});
</script>

<ArticleMentionUpdate {articleMention} />
