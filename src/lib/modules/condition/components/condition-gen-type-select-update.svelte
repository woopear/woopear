<script lang="ts">
  import BoxCardEntitiesBody from '$lib/modules/components/boxs/box-card-entities-body.svelte';
  import BoxCardEntitiesBoxBtnForm from '$lib/modules/components/boxs/box-card-entities-box-btn-form.svelte';
  import BoxCardEntitiesHead from '$lib/modules/components/boxs/box-card-entities-head.svelte';
  import BoxCardEntities from '$lib/modules/components/boxs/box-card-entities.svelte';
  import BoxContentBody from '$lib/modules/components/boxs/box-content-body.svelte';
  import BoxContentHeader from '$lib/modules/components/boxs/box-content-header.svelte';
  import BtnAdd from '$lib/modules/components/btn/btn-add.svelte';
  import BtnCloseUpdate from '$lib/modules/components/btn/btn-close-update.svelte';
  import BtnDelete from '$lib/modules/components/btn/btn-delete.svelte';
  import Input from '$lib/modules/components/input/input.svelte';
  import Texarea from '$lib/modules/components/textarea/texarea.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import Tooltip from '$lib/modules/components/tooltip/tooltip.svelte';
  import { createObjectAsFormData } from '$lib/providers/format/format.service';
  import { createEventDispatcher } from 'svelte';
  import { condition_gen_selected_store } from '../store/condition-gen-selected.store';
  import { condition_gen_type_content_store } from '../store/condition-gen-type-content.store';
  import { condition_gen_type_selected_store } from '../store/condition-gen-type-selected.store';

  let loader_save_condition_gen_type_selected = '';
  let loader_save_content = '';

  // creation event dispatch
  const dist = createEventDispatcher();

  /**
   * fermeture du volet de modification de la presentation
   */
  function closeUpdate(): void {
    dist('close_update', false);
  }

  /**
   * modification de la condition type selectionné
   * @param e => event form
   * @param idConditionTypeSelect => id de la condition type selectionné
   */
  async function updateConditionGenTypeSelected(e, idConditionTypeSelect: string): Promise<void> {
    // creation des données
    const data = createObjectAsFormData(e.target);
    // modification
    await condition_gen_type_selected_store.updateConditionGenTypeSelected(
      data,
      idConditionTypeSelect,
      $condition_gen_selected_store.id
    );
  }

  /**
   * ajoute un contenu à la condition gen type selectionné
   * @param idConditioGenType id de la condition gen type selectionné
   */
  async function addContentConditionGenType(idConditioGenType: string): Promise<void> {
    await condition_gen_type_content_store.addContentConditionGenTypeSelected(
      $condition_gen_selected_store.id,
      idConditioGenType
    );
  }

  /**
   * delete un content de la condition gen type selectionné
   * @param idConditionGenTypeSelected id de la condition gen type selectionné
   * @param idContent id de la condition gen type contents
   */
  async function deleteContentConditionGenTypeSelected(
    idConditionGenTypeSelected: string,
    idContent: string
  ): Promise<void> {
    await condition_gen_type_content_store.deleteContentConditionGenTypeSelected(
      $condition_gen_selected_store.id,
      idConditionGenTypeSelected,
      idContent
    );
  }

  /**
   * modification des contents du condition gen type selectionné
   * @param idConditionGenTypeSelected id de condition gen type selected
   * @param idConditionGenSelected id de la condition gen selected
   */
  async function updateAllContentConditionGenTypeSelected(
    idConditionGenTypeSelected: string,
    idConditionGenSelected: string
  ): Promise<void> {
    await condition_gen_type_content_store.updateContentConditionGenTypeSelected(
      idConditionGenSelected,
      idConditionGenTypeSelected
    );
  }
</script>

{#if 'id' in $condition_gen_type_selected_store}
  <BoxCardEntities>
    <!-- en tete -->
    <BoxCardEntitiesHead>
      <Title slot="title-1" title="Modification de" type_title={ETypeTitle.H4} />
      <span slot="title-2" class="md:ml-4">{$condition_gen_type_selected_store.title}</span>
      <BtnCloseUpdate
        slot="btn-close-update"
        changeUpdate={closeUpdate}
        relief={true}
        size="w-4 h-4"
      />
    </BoxCardEntitiesHead>

    <!-- partie condition gen type selected -->
    <BoxCardEntitiesBody>
      <form
        on:submit|preventDefault={async (e) =>
          await updateConditionGenTypeSelected(e, $condition_gen_type_selected_store.id)}
      >
        <!-- title -->
        <div>
          <!-- svelte-ignore a11y-label-has-associated-control -->
          <label> Titre de la condition : </label>
          <Input
            name="title"
            placeholder="titre"
            value={$condition_gen_type_selected_store.title}
          />
        </div>

        <!-- sub title -->
        <div>
          <!-- svelte-ignore a11y-label-has-associated-control -->
          <label> Sous titre de la condition : </label>
          <Input
            name="sub_title"
            placeholder="sous titre"
            value={$condition_gen_type_selected_store.sub_title}
          />
        </div>

        <!-- type -->
        <div>
          <!-- svelte-ignore a11y-label-has-associated-control -->
          <label>
            Type de la condition <span class="text-2xs font-bold"
              >(format ex : mentions-legales)</span
            > :
          </label>
          <Input
            name="type"
            placeholder="type de la condition"
            value={$condition_gen_type_selected_store.type}
          />
        </div>

        <!-- btn modifier condition generale -->
        <BoxCardEntitiesBoxBtnForm>
          <button class={`${loader_save_condition_gen_type_selected} btn btn-primary mt-12`}
            >Valider</button
          >
        </BoxCardEntitiesBoxBtnForm>
      </form>
    </BoxCardEntitiesBody>

    <!-- Partie Content -->
    <!-- en tete -->
    <BoxContentHeader>
      <Title slot="title-content" title="Partie contenu" type_title={ETypeTitle.H6} />
      <!-- btn ajout content -->
      <Tooltip slot="add-content" data="ajouter un contenu">
        <BtnAdd
          changeUpdate={() => addContentConditionGenType($condition_gen_type_selected_store.id)}
        />
      </Tooltip>
    </BoxContentHeader>

    <!-- form contents -->
    {#each $condition_gen_type_content_store as content, i (content.id)}
      <BoxContentBody id={content.id}>
        <p slot="title">Document numéro : {content.id}</p>
        <Tooltip slot="btn-delete" data="Supprimer le contenu">
          <BtnDelete
            size="w-5 h-5"
            changeUpdate={() =>
              deleteContentConditionGenTypeSelected(
                $condition_gen_type_selected_store.id,
                content.id
              )}
          />
        </Tooltip>
        <div slot="input-content">
          <!-- svelte-ignore a11y-label-has-associated-control -->
          <label>Texte du contenu : </label>
          <Texarea
            name="content"
            bind:value={content.content}
            placeholder="Texte de la présentation"
          />
        </div>
      </BoxContentBody>
    {/each}
    <!-- btn modifier content -->
    {#if $condition_gen_type_content_store.length !== 0}
      <BoxCardEntitiesBoxBtnForm>
        <button
          class={`${loader_save_content} btn btn-primary mt-12`}
          on:click={() =>
            updateAllContentConditionGenTypeSelected(
              $condition_gen_type_selected_store.id,
              $condition_gen_selected_store.id
            )}>Enregistrer les contenus</button
        >
      </BoxCardEntitiesBoxBtnForm>
    {/if}
  </BoxCardEntities>
{/if}
