<script lang="ts">
  import BtnDelete from '$lib/modules/components/btn/btn-delete.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import { presentation_store, presentation_selected_store } from '../presentation.store';
  import PresentationUpdate from './presentation-update.svelte';

  let see_update = false;

  const closeUpdate = (e) => {
    see_update = e.details;
  };

  /**
   * selected presentation pour modification
   * @param id
   */
  const selectedForPresentation = (id: string): void => {
    see_update = true;
    presentation_selected_store.set($presentation_store.find((el) => el.id === id));
  };

  /**
   * delete presentation
   * @param id
   */
  const deletePresentation = (id: string): void => {
    console.log('coucou');
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
              <td class="flex">
                <BtnUpdate changeUpdate={() => selectedForPresentation(presentation.id)} />
                <BtnDelete changeUpdate={() => deletePresentation(presentation.id)} />
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
  {#if see_update}
    <PresentationUpdate on:close_update={closeUpdate} />
  {/if}
</section>
