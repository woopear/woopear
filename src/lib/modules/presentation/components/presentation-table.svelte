<script lang="ts">
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import { presentation_store } from '../presentation.store';
  import type { IPresentation } from '../presentation.type';
  import PresentationUpdate from './presentation-update.svelte';

  let presentation_selected: IPresentation = {};

  const selectedForPresentation = (id) => {
    presentation_selected = $presentation_store.find((el) => el.id === id);
  };
</script>

<section class="overflow-x-auto">
  <!-- tableau -->
  <table class="table w-full">
    <!-- head -->
    <thead>
      <tr>
        <th>id</th>
        <th>Titre</th>
        <th>Nb contents</th>
        <th>Actions</th>
      </tr>
    </thead>
    <!-- corps -->
    <tbody>
      {#if $presentation_store}
        <!-- si il y a des entrées on affiche sinon on affiche 0 -->
        {#if $presentation_store.length > 0}
          {#each $presentation_store as presentation}
            <tr>
              <th>{presentation.id}</th>
              <td>{presentation.title}</td>
              <td>{presentation.contents ? presentation.contents.length : ''}</td>
              <td>
                <BtnUpdate changeUpdate={() => selectedForPresentation(presentation.id)} />
              </td>
            </tr>
          {/each}
        {:else}
          <tr> 0 </tr>
        {/if}
      {/if}
    </tbody>
  </table>
</section>
<!-- update presentation -->
<section>
  {#if 'id' in presentation_selected}
    <PresentationUpdate {presentation_selected} closeUpdate={() => (presentation_selected = {})} />
  {/if}
</section>
