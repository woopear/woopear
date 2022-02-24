<script lang="ts">
  import BtnCloseUpdate from '$lib/modules/components/btn/btn-close-update.svelte';
  import Input from '$lib/modules/components/input/input.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import SpinnerLittle from '$lib/modules/spinner/components/spinner-little.svelte';
  import { createObjectAsFormData } from '$lib/providers/format/format.service';
  import { createEventDispatcher } from 'svelte';
  import type { IConditionGeneral } from '../condition.type';
  import { condition_gen_selected_store } from '../store/condition-gen-selected.store';
  import { condition_gen_type_content_store } from '../store/condition-gen-type-content.store';
  import { condition_gen_type_selected_store } from '../store/condition-gen-type-selected.store';
  import { condition_gen_type_store } from '../store/condition-gen-type.store';
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
  <section class="card mt-16 card bg-base-200 px-6 py-8 md:px-12">
    <!-- en-tete -->
    <section class="card-title flex items-start md:items-center justify-between">
      <div class="md:flex md:items-end">
        <Title title="Modification de" type_title={ETypeTitle.H4} />
        <span class="md:ml-4">{$condition_gen_selected_store.title}</span>
      </div>
      <BtnCloseUpdate changeUpdate={closeUpdate} relief={true} size="w-4 h-4" />
    </section>

    <!-- modification condition generale -->
    <section class="mt-12">
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
        <div class="flex justify-end">
          <button class={`${loader_save_condition_gen_selected} btn btn-primary mt-12`}
            >Valider</button
          >
        </div>
      </form>
    </section>
  </section>

  <!-- partie condition type -->
  <ConditionGenTypeTable />
{:else}
  <SpinnerLittle />
{/if}

<style>
  label {
    font-weight: 700;
  }
</style>
