<script lang="ts">
  import BoxTable from '$lib/modules/components/boxs/box-table.svelte';
  import BoxTitleTab from '$lib/modules/components/boxs/box-title-tab.svelte';
  import BtnAddEntities from '$lib/modules/components/btn/btn-add-entities.svelte';
  import BtnDelete from '$lib/modules/components/btn/btn-delete.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
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

<!-- title tableau -->
<BoxTitleTab>
  <Title title="Liste des conditions générales" type_title={ETypeTitle.H4} />
</BoxTitleTab>

<!-- tableau condition gen -->
<BoxTable>
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
</BoxTable>

<!-- partie btn ajout condition gen -->
<BtnAddEntities handlerClick={() => addConditionGen()} />

<!-- update condition gen -->
{#if see_update}
  <ConditionGenSelectUpdate on:close_update={closeUpdate} />
{/if}
