<script lang="ts">
  import BoxCardEntities from '$lib/modules/components/boxs/box-card-entities.svelte';
  import BtnCloseUpdate from '$lib/modules/components/btn/btn-close-update.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import BoxCardEntitesHead from '$lib/modules/components/boxs/box-card-entities-head.svelte';
  import BoxCardEntitiesBody from '$lib/modules/components/boxs/box-card-entities-body.svelte';
  import { createEventDispatcher } from 'svelte';
  import { webapp_selected_store } from '../store/webapp-selected.store';
  import Input from '$lib/modules/components/input/input.svelte';
  import BoxCardEntitiesBoxBtnForm from '$lib/modules/components/boxs/box-card-entities-box-btn-form.svelte';
  import ImgEmptySvg from '$lib/modules/components/img-empty-svg/img-empty-svg.svelte';
  import { createObjectAsFormData } from '$lib/providers/format/format.service';

  let loader_save_webapp_selected = '';
  let loader_sup_img_webapp = '';
  let loader_img_webapp = '';
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
   * load file image dans la variable img
   * @param e event onChange input file
   */
  function loadImageWebappSelected(e): void {
    img = e.target.files[0];
  }

  /**
   * ajout de l'image au web app selected
   * @param idWebappSelected id de la webapp selected
   */
  async function uploadImg(idWebappSelected: string): Promise<void> {
    loader_img_webapp = 'loading';
    await webapp_selected_store.uploadImageWebappSelected(img, idWebappSelected);
    loader_img_webapp = '';
  }

  /**
   * suppression de l'image au web app selected
   * @param idWebappSelected id de la webapp selected
   */
  async function deleteImage(idWebappSelected: string): Promise<void> {
    loader_sup_img_webapp = 'loading';
    await webapp_selected_store.deleteImageWebappSelected(idWebappSelected);
    loader_sup_img_webapp = '';
  }

  /**
   * modification du webapp selected
   */
  async function updatewebappSelected(e, idWebappSelected: string): Promise<void> {
    loader_save_webapp_selected = 'loading';
    const data = createObjectAsFormData(e.target);
    await webapp_selected_store.updateWebappSelected(idWebappSelected, data);
    loader_save_webapp_selected = '';
  }
</script>

{#if 'id' in $webapp_selected_store}
  <BoxCardEntities>
    <!-- en-tete -->
    <BoxCardEntitesHead>
      <Title slot="title-1" title="Modification de" type_title={ETypeTitle.H4} />
      <span slot="title-2" class="md:ml-4">{$webapp_selected_store.title}</span>
      <BtnCloseUpdate
        slot="btn-close-update"
        changeUpdate={closeUpdate}
        relief={true}
        size="w-4 h-4"
      />
    </BoxCardEntitesHead>

    <!-- modification ajout d'une image -->
    <section class="flex flex-col items-center justify-center mb-24 mt-12">
      <div class="flex flex-col items-center">
        <!-- si pas d'image on affiche svg de remplacement -->
        {#if $webapp_selected_store.image !== ''}
          <img class="w-44 h-44 mt-8 mb-2" src={`${$webapp_selected_store.image}`} alt="webapp" />
        {:else}
          <ImgEmptySvg />
        {/if}
        <p class="text-center font-bold mt-4">Modifier l'image</p>
      </div>
      <!-- input file -->
      <div class="flex justify-center my-6">
        <div class="w-96">
          <input
            class="form-control
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
            on:change={loadImageWebappSelected}
          />
        </div>
      </div>
      <!-- btn envoie ou suppression img -->
      <div class="flex">
        <button
          class={`${loader_sup_img_webapp} btn btn-xs btn-secondary mr-4`}
          on:click={() => deleteImage($webapp_selected_store.id)}>Supprimer l'image</button
        >
        <button
          class={`${loader_img_webapp} btn btn-xs btn-primary`}
          on:click={() => uploadImg($webapp_selected_store.id)}>Envoyer</button
        >
      </div>
    </section>

    <!-- modification d'un webapp -->
    <BoxCardEntitiesBody>
      <!-- form donnée principal -->
      <form
        on:submit|preventDefault={async (e) =>
          await updatewebappSelected(e, $webapp_selected_store.id)}
      >
        <!-- title -->
        <div>
          <!-- svelte-ignore a11y-label-has-associated-control -->
          <label> Title : </label>
          <Input name="title" placeholder="titre" value={$webapp_selected_store.title} />
        </div>
        <!-- description -->
        <div>
          <!-- svelte-ignore a11y-label-has-associated-control -->
          <label> Description : </label>
          <Input
            name="description"
            placeholder="description"
            value={$webapp_selected_store.description}
          />
        </div>
        <!-- btn modifier condition generale -->
        <BoxCardEntitiesBoxBtnForm>
          <button class={`${loader_save_webapp_selected} btn btn-primary mt-12`}>Valider</button>
        </BoxCardEntitiesBoxBtnForm>
      </form>
    </BoxCardEntitiesBody>
  </BoxCardEntities>
{/if}
