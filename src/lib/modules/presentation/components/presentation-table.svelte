<script lang="ts">
  import AddSvg from '$lib/modules/components/add-svg/add-svg.svelte';
  import BtnDelete from '$lib/modules/components/btn/btn-delete.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import Tooltip from '$lib/modules/components/tooltip/tooltip.svelte';
  import { presentation_store, presentation_selected_store } from '../presentation.store';
  import PresentationUpdate from './presentation-update.svelte';
  import { fade } from 'svelte/transition';

  let see_update = false;

  /**
   * fermeture du volet de modification
   * @param e event venant du composant
   */
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
   * active ou désactive presentation
   * @param e => event onChange
   * @param idPresentation => id de la presentation
   */
  async function activeDisablePresentation(e, idPresentation: string) {
    await presentation_store.updatePresentation(idPresentation, { active: e.target.checked });
  }
</script>

<section class="overflow-x-auto">
  <!-- tableau -->
  <table class="table w-full h-fit">
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
          {#each $presentation_store as presentation (presentation.id)}
            <tr>
              <th>{presentation.id}</th>
              <td>{presentation.title === '' ? 'sans titre' : presentation.title}</td>
              <td>{presentation.contents ? presentation.contents.length : ''}</td>
              <td class="flex items-center">
                <input
                  type="checkbox"
                  class="toggle toggle-secondary toggle-xs mx-2"
                  checked={presentation.active}
                  on:change={(e) => activeDisablePresentation(e, presentation.id)}
                />
                <BtnUpdate changeUpdate={() => selectedForPresentation(presentation.id)} />
                <BtnDelete
                  changeUpdate={async () =>
                    await presentation_store.deletePresentation(presentation.id)}
                />
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

<!-- partie btn ajout presentation -->
<section
  on:click={async () => await presentation_store.addPresentation()}
  class="cursor-pointer mt-6 mb-12 w-full btn btn-primary rounded-lg h-10 flex justify-center items-center"
>
  <Tooltip data="ajouter une présentation">
    <AddSvg style="font-bold text-base-200" />
  </Tooltip>
</section>

<!-- update presentation -->
<section>
  {#if see_update}
    <PresentationUpdate on:close_update={closeUpdate} />
  {/if}
</section>
