<script lang="ts">
  import AddSvg from '$lib/modules/components/add-svg/add-svg.svelte';
  import BtnDelete from '$lib/modules/components/btn/btn-delete.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import Tooltip from '$lib/modules/components/tooltip/tooltip.svelte';
  import { condition_gen_type_store } from '../condition.store';
  import { condition_gen_selected_store } from '../store/condition-gen-selected.store';
  import { condition_gen_type_content_store } from '../store/condition-gen-type-content.store';
  import { condition_gen_type_selected_store } from '../store/condition-gen-type-selected.store';
  import ConditionGenTypeSelectUpdate from './condition-gen-type-select-update.svelte';

  let see_update = false;

  /**
   * retour de fonction du composant
   * condition-gen-select-update
   * permet de fermer le volet update
   * @param e event click
   */
  function closeUpdate(e) {
    see_update = e.details;
  }

  /**
   * selection d'un type condition
   * @param idCondition id de la type condition
   */
  function selectedConditionGenType(idCondition: string): void {
    // ecoute de la condition type selectionné
    condition_gen_type_selected_store.listenConditionGenTypeSelected(
      idCondition,
      $condition_gen_selected_store.id
    );

    // on ecoute les contents du type de la condition selectionné
    condition_gen_type_content_store.listenConditionGenTypeContent(
      $condition_gen_selected_store.id,
      idCondition
    );

    //on ouvre le volet update
    see_update = true;
  }

  /**
   * creation d'un type de condition
   */
  async function addConditionGenType(): Promise<void> {
    await condition_gen_type_store.addTypeConditionGenSelected($condition_gen_selected_store.id);
  }

  /**
   * delete une type condition
   * @param idCondition id de la condition à supprimer
   */
  async function deleteConditionGenType(idCondition: string): Promise<void> {
    await condition_gen_type_store.deleteTypeConditionGenSelected(
      idCondition,
      $condition_gen_selected_store.id
    );
  }
</script>

<div class="mt-16 mb-12">
  <Title
    title={`Liste des articles de ${$condition_gen_selected_store.title}`}
    type_title={ETypeTitle.H4}
  />
</div>
<section class="overflow-x-auto">
  <!-- tableau -->
  <table class="table w-full h-fit">
    <!-- head -->
    <thead>
      <tr>
        <th>id</th>
        <th>Titre</th>
        <th>Type</th>
        <th>Actions</th>
      </tr>
    </thead>
    <!-- corps -->
    <tbody>
      {#if $condition_gen_type_store}
        <!-- si il y a des entrées on affiche sinon on affiche 0 -->
        {#if $condition_gen_type_store.length > 0}
          {#each $condition_gen_type_store as condition (condition.id)}
            <tr>
              <th>{condition.id}</th>
              <td>{condition.title === '' ? 'sans titre' : condition.title}</td>
              <td>{condition.type === '' ? 'sans type' : condition.type}</td>
              <td class="flex items-center">
                <BtnUpdate changeUpdate={() => selectedConditionGenType(condition.id)} />
                <BtnDelete changeUpdate={() => deleteConditionGenType(condition.id)} />
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
  on:click={() => addConditionGenType()}
  class="cursor-pointer mt-6 mb-12 w-full btn btn-primary rounded-lg h-10 flex justify-center items-center"
>
  <Tooltip data="ajouter un article de condition générale">
    <AddSvg style="font-bold text-base-200" />
  </Tooltip>
</section>

<!-- update presentation -->
<section>
  {#if see_update}
    <ConditionGenTypeSelectUpdate on:close_update={closeUpdate} />
  {/if}
</section>
