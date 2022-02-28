<script lang="ts">
  import BoxCardEntitiesBody from '$lib/modules/components/boxs/box-card-entities-body.svelte';
  import BoxCardEntitiesBoxBtnForm from '$lib/modules/components/boxs/box-card-entities-box-btn-form.svelte';
  import BoxCardEntitiesHead from '$lib/modules/components/boxs/box-card-entities-head.svelte';
  import BoxCardEntities from '$lib/modules/components/boxs/box-card-entities.svelte';
  import BtnCloseUpdate from '$lib/modules/components/btn/btn-close-update.svelte';
  import ImgEmptySvg from '$lib/modules/components/img-empty-svg/img-empty-svg.svelte';
  import Input from '$lib/modules/components/input/input.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import { createObjectAsFormData } from '$lib/providers/format/format.service';
  import { createEventDispatcher } from 'svelte';
  import { team_producer_selected_store } from '../store/producer-selected.store';
  import { team_seletect_store } from '../store/team-selected.store';

  let loader_save_team_product_selected = '';
  let loader_sup_img_producer = '';
  let loader_img_producer = '';
  let img;

  // creation event dispatch
  const dist = createEventDispatcher();

  /**
   * fermeture du volet de modification de la presentation
   */
  function closeUpdate(): void {
    dist('close_update', false);
  }

  /**
   * load image
   * @param e event onchange
   */
  function loadImageProductSelected(e): void {
    img = e.target.files[0];
  }

  /**
   * modification de la personne de l'équipe
   * @param e event form
   * @param idTeamProducerSelected id du producer selected
   */
  async function updateTeamProductSelected(e, idTeamProducerSelected: string): Promise<void> {
    const data = createObjectAsFormData(e.target);
    await team_producer_selected_store.updateTeamProducerSelected(
      data,
      $team_seletect_store.id,
      idTeamProducerSelected
    );
  }

  /**
   * upload image
   * @param idTeamProducerSelected id du producer selectionné
   */
  async function uploadImg(idTeamProducerSelected: string): Promise<void> {
    await team_producer_selected_store.uploadImageTeamProducerSelected(
      img,
      $team_seletect_store.id,
      idTeamProducerSelected
    );
  }

  /**
   * delete image
   * @param idTeamProducerSelected id du producer selectionné
   */
  async function deleteImage(idTeamProducerSelected: string): Promise<void> {
    await team_producer_selected_store.deleteImageTeamProducerSelected(
      $team_seletect_store.id,
      idTeamProducerSelected
    );
  }
</script>

<BoxCardEntities>
  <!-- head -->
  <BoxCardEntitiesHead>
    <Title slot="title-1" title="Modification de" type_title={ETypeTitle.H4} />
    <span slot="title-2" class="md:ml-4">{$team_producer_selected_store.full_name}</span>
    <BtnCloseUpdate
      slot="btn-close-update"
      changeUpdate={closeUpdate}
      relief={true}
      size="w-4 h-4"
    />
  </BoxCardEntitiesHead>

  <!-- upload image -->
  <section class="flex flex-col items-center justify-center mb-24 mt-12">
    <div class="flex flex-col items-center">
      <!-- si pas d'image on affiche svg de remplacement -->
      {#if $team_producer_selected_store.image !== ''}
        <img
          class="w-56 h-44 mt-8 mb-2"
          src={`${$team_producer_selected_store.image}`}
          alt="webapp"
        />
      {:else}
        <ImgEmptySvg />
      {/if}
      <p class="text-center font-bold mt-4">Modifier l'image</p>
    </div>
    <!-- input file -->
    <div class="flex justify-center my-6">
      <div class="w-96">
        <input
          class="img-webapp-selected form-control
        block
        w-8/12
        sm:w-10/12
        m-auto
        px-2
        py-1
        text-sm
        font-normal
        text-gray-700
        bg-white bg-clip-padding
        border border-solid border-gray-300
        rounded
        transition
        ease-in-out
        focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
          id="formFileSm"
          type="file"
          on:change={loadImageProductSelected}
        />
      </div>
    </div>
    <!-- btn envoie ou suppression img -->
    <div class="flex">
      <button
        class={`${loader_sup_img_producer} btn btn-xs btn-secondary mr-4`}
        on:click={() => deleteImage($team_producer_selected_store.id)}>Supprimer l'image</button
      >
      <button
        class={`${loader_img_producer} btn btn-xs btn-primary`}
        on:click={() => uploadImg($team_producer_selected_store.id)}>Enregistrer</button
      >
    </div>
  </section>

  <!-- body -->
  <BoxCardEntitiesBody>
    <form
      on:submit|preventDefault={async (e) =>
        await updateTeamProductSelected(e, $team_producer_selected_store.id)}
    >
      <!-- title -->
      <div>
        <!-- svelte-ignore a11y-label-has-associated-control -->
        <label>Nom de la personne : </label>
        <Input
          name="full_name"
          placeholder="nom, prénom"
          value={$team_producer_selected_store.full_name}
        />
      </div>

      <!-- description -->
      <div>
        <!-- svelte-ignore a11y-label-has-associated-control -->
        <label>Présentation de la personne : </label>
        <Input
          name="description"
          placeholder="votre description"
          value={$team_producer_selected_store.description}
        />
      </div>

      <!-- job -->
      <div>
        <!-- svelte-ignore a11y-label-has-associated-control -->
        <label>Le job : </label>
        <Input name="job" placeholder="votre job" value={$team_producer_selected_store.job} />
      </div>
      <!-- btn modifier condition generale -->
      <BoxCardEntitiesBoxBtnForm>
        <button class={`${loader_save_team_product_selected} btn btn-primary mt-12`}>Valider</button
        >
      </BoxCardEntitiesBoxBtnForm>
    </form>
  </BoxCardEntitiesBody>
</BoxCardEntities>
