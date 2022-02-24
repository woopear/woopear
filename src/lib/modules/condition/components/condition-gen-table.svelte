<script lang="ts">
  import AddSvg from '$lib/modules/components/add-svg/add-svg.svelte';
  import BtnDelete from '$lib/modules/components/btn/btn-delete.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import Tooltip from '$lib/modules/components/tooltip/tooltip.svelte';
  import { condition_gen_selected_store } from '../store/condition-gen-selected.store';
  import { condition_gen_type_store } from '../store/condition-gen-type.store';
  import { condition_gen_store } from '../store/condition-gen.store';
  import ConditionGenSelectUpdate from './condition-gen-select-update.svelte';

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
   * active/desactive conditions_gen
   * @param e => event check
   * @param idCondition => id de la condition ciblé
   */
  async function activeDisableConditionGen(e, idCondition: string): Promise<void> {
    await condition_gen_store.updateConditionGen(idCondition, { active: e.target.checked });
  }

  /**
   * ecoute la condition gen selectionné
   * @param idCondition
   */
  function selectedConditionGen(idCondition: string): void {
    // on ecoute condition gen selectionné
    condition_gen_selected_store.listenConditionGenSelected(idCondition);

    // on ecoute la collection conditions du document condition gen selectionné
    condition_gen_type_store.listenConditionGenSelectedType(idCondition);
    //on ouvre le volet update
    see_update = true;
  }

  /**
   * ajoute condition gen
   */
  async function addConditionGen(): Promise<void> {
    await condition_gen_store.addConditionGen();
  }

  /**
   * supprime condition gen
   */
  async function deleteConditionGen(idCondition: string): Promise<void> {
    await condition_gen_store.deleteConditionGen(idCondition);
    //on ferme le volet update
    see_update = false;
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
        <th>Actions</th>
      </tr>
    </thead>
    <!-- corps -->
    <tbody>
      {#if $condition_gen_store}
        <!-- si il y a des entrées on affiche sinon on affiche 0 -->
        {#if $condition_gen_store.length > 0}
          {#each $condition_gen_store as condition (condition.id)}
            <tr>
              <th>{condition.id}</th>
              <td>{condition.title === '' ? 'sans titre' : condition.title}</td>
              <td class="flex items-center">
                <input
                  type="checkbox"
                  class="toggle toggle-secondary toggle-xs mx-2"
                  checked={condition.active}
                  on:change={(e) => activeDisableConditionGen(e, condition.id)}
                />
                <BtnUpdate changeUpdate={() => selectedConditionGen(condition.id)} />
                <BtnDelete changeUpdate={() => deleteConditionGen(condition.id)} />
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
  on:click={() => addConditionGen()}
  class="cursor-pointer mt-6 mb-12 w-full btn btn-primary rounded-lg h-10 flex justify-center items-center"
>
  <Tooltip data="ajouter une condition générale">
    <AddSvg style="font-bold text-base-200" />
  </Tooltip>
</section>

<!-- update presentation -->
<section>
  {#if see_update}
    <ConditionGenSelectUpdate on:close_update={closeUpdate} />
  {/if}
</section>
