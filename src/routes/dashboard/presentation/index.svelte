<script lang="ts">
  import { session } from '$app/stores';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import PresentationTable from '$lib/modules/presentation/components/presentation-table.svelte';
  import { presentation_store } from '$lib/modules/presentation/presentation.store';
  import SpinnerLittle from '$lib/modules/spinner/components/spinner-little.svelte';
  import { current_user_store } from '$lib/modules/user/user.store';
  import { onMount } from 'svelte';

  onMount(async () => {
    // si session.user existe
    // on lance l'ecouteur sur le document user
    if ($session.user) {
      current_user_store.getUser($session.user.uid);
    }

    // si présentation n'est pas encore request on request
    if ($presentation_store.length === 0) {
      await presentation_store.listenPresentation();
    }
  });
</script>

<section class="w-full flex-1 pl-6 pt-6 pb-6">
  <div class="mb-12">
    <Title title="Liste des présentations de woopear" type_title={ETypeTitle.H4} />
  </div>
  {#if $presentation_store.length !== 0}
    <PresentationTable />
  {:else}
    <SpinnerLittle />
  {/if}
</section>
