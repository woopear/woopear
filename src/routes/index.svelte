<script lang="ts">
  import Anime from '$lib/modules/waiting/components/anime.svelte';
  import Waiting from '$lib/modules/waiting/components/waiting.svelte';

  // pour activer la construction du site
  let waiting_active = false;
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
