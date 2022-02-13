<script>
  import Anime from '$lib/modules/waiting/components/anime.svelte';
  import Waiting from '$lib/modules/waiting/components/waiting.svelte';

  // pour activer la construction du site
  let waiting_active = true;
</script>

{#if waiting_active}
  <!-- animation  -->
  <Anime />
  <!-- waiting -->
  <Waiting />
{:else}
  <p>woopear</p>
{/if}
