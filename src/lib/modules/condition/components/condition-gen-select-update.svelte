<script lang="ts">
  import { createEventDispatcher } from 'svelte';

  import { condition_gen_selected_store } from '../store/condition-gen-selected.store';

  // creation event dispatch
  const dist = createEventDispatcher();

  /**
   * fermeture du volet de modification de la presentation
   */
  function closeUpdate(): void {
    dist('close_update', false);
    // on reset le store presentation selected au moment de la fermeture du volet
    condition_gen_selected_store.stopListenConditionGenSelected();
    condition_gen_selected_store.resetConditionGenSelected();
  }
</script>

<section>
  {#if $condition_gen_selected_store}
    {JSON.stringify($condition_gen_selected_store)}
  {/if}
</section>
