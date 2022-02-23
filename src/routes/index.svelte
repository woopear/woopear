<script lang="ts">
  import { presentation_store } from '$lib/modules/presentation/presentation.store';
  import Anime from '$lib/modules/waiting/components/anime.svelte';
  import Waiting from '$lib/modules/waiting/components/waiting.svelte';
  import { onMount } from 'svelte';

  // pour activer la construction du site
  let waiting_active = false;

  onMount(() => {
    // si présentation n'est pas encore écouter, ecoute presentation
    if (!('id' in $presentation_store)) {
      presentation_store.getPresentation();
    }
  });
</script>

<!-- head -->
<svelte:head>
  <title>Woopear</title>
</svelte:head>

{#if waiting_active}
  <!-- animation  -->
  <Anime />
  <!-- waitings -->
  <Waiting />
{:else}
  <h1>woopear</h1>
{/if}
