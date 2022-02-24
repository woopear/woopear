<script lang="ts">
  import BoxCardEntitiesBody from '$lib/modules/components/boxs/box-card-entities-body.svelte';
  import BoxCardEntitiesBoxBtnForm from '$lib/modules/components/boxs/box-card-entities-box-btn-form.svelte';
  import BoxCardEntitesHead from '$lib/modules/components/boxs/box-card-entities-head.svelte';
  import BoxCardEntities from '$lib/modules/components/boxs/box-card-entities.svelte';
  import BtnCloseUpdate from '$lib/modules/components/btn/btn-close-update.svelte';
  import Input from '$lib/modules/components/input/input.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import SpinnerLittle from '$lib/modules/spinner/components/spinner-little.svelte';
  import { createObjectAsFormData } from '$lib/providers/format/format.service';
  import { createEventDispatcher } from 'svelte';
  import type { IConditionGeneral } from '../condition.type';
  import { condition_gen_selected_store } from '../store/condition-gen-selected.store';
  import ConditionGenTypeTable from './condition-gen-type-table.svelte';

  let loader_save_condition_gen_selected = '';

  // creation event dispatch
  const dist = createEventDispatcher();

  /**
   * fermeture du volet de modification de la presentation
   */
  function closeUpdate(): void {
    dist('close_update', false);
  }

  /**
   * modification de la condition gen selected
   * @param e => event form
   * @param idCondition => id de la condition selectionné
   */
  async function updateConditionGenSelected(e, idCondition: string): Promise<void> {
    loader_save_condition_gen_selected = 'loading';
    // creation des datas
    const data = createObjectAsFormData<IConditionGeneral>(e.target);
    // modification
    await condition_gen_selected_store.updateConditionGenSelected(idCondition, data);
    loader_save_condition_gen_selected = '';
  }
</script>

{#if 'id' in $condition_gen_selected_store}
  <BoxCardEntities>
    <!-- en-tete -->
    <BoxCardEntitesHead>
      <Title slot="title-1" title="Modification de" type_title={ETypeTitle.H4} />
      <span slot="title-2" class="md:ml-4">{$condition_gen_selected_store.title}</span>
      <BtnCloseUpdate
        slot="btn-close-update"
        changeUpdate={closeUpdate}
        relief={true}
        size="w-4 h-4"
      />
    </BoxCardEntitesHead>

    <!-- modification condition generale -->
    <BoxCardEntitiesBody>
      <form
        on:submit|preventDefault={async (e) =>
          await updateConditionGenSelected(e, $condition_gen_selected_store.id)}
      >
        <div>
          <!-- svelte-ignore a11y-label-has-associated-control -->
          <label
            >Titre de la condition générale <span class="text-2xs"
              >(présiser la date, ex : titre data)</span
            > :
          </label>
          <Input name="title" placeholder="titre" value={$condition_gen_selected_store.title} />
        </div>
        <!-- btn modifier condition generale -->
        <BoxCardEntitiesBoxBtnForm>
          <button class={`${loader_save_condition_gen_selected} btn btn-primary mt-12`}
            >Valider</button
          >
        </BoxCardEntitiesBoxBtnForm>
      </form>
    </BoxCardEntitiesBody>
  </BoxCardEntities>

  <!-- partie condition type -->
  <ConditionGenTypeTable />
{:else}
  <SpinnerLittle />
{/if}
