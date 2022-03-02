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
  import SpinnerLittle from '$lib/modules/spinner/components/spinner-little.svelte';
  import { createObjectAsFormData } from '$lib/providers/format/format.service';
  import { createEventDispatcher } from 'svelte';
  import { advertising_selected_store } from '../store/advertising-selected.store';
  import AdvertisingArticleTable from './advertising-article-table.svelte';

  let loader_save_advertising_article_selected = '';
  let loader_sup_img_advertising = '';
  let loader_img_advertising = '';
  let img;

  // creation event dispatch
  const dist = createEventDispatcher();

  /**
   * fermeture du volet de modification de la publicité
   */
  function closeUpdate(): void {
    dist('close_update', false);
  }

  /**
   * modification de l'article de la publicité selectionné
   */
  async function updateAdvertisingArticleSelected(e, idAdvertisingArticleSelected) {
    loader_save_advertising_article_selected = 'loading';
    // création des données en form data
    const data = createObjectAsFormData(e.target);

    // modification
    await advertising_selected_store.updateAdvertisingSelected(idAdvertisingArticleSelected, data);
    loader_save_advertising_article_selected = '';
  }

  /**
   * load file image dans la variable img
   * @param e event onChange input file
   */
  function loadImageWebappSelected(e): void {
    img = e.target.files[0];
  }
  /**
   * ajout de l'image a la publicité selected
   * @param idAdvertisingSelected id de la publicité selected
   */
  async function uploadImg(idAdvertisingSelected: string): Promise<void> {
    loader_img_advertising = 'loading';
    await advertising_selected_store.uploadImageAdvertisingSelected(img, idAdvertisingSelected);
    loader_img_advertising = '';
  }

  /**
   * suppression de l'image au web app selected
   * @param idAdvertisingSelected id de la webapp selected
   */
  async function deleteImage(idAdvertisingSelected: string): Promise<void> {
    loader_sup_img_advertising = 'loading';
    await advertising_selected_store.deleteImageAdvertisingSelected(idAdvertisingSelected);
    loader_sup_img_advertising = '';
  }
</script>

{#if 'id' in $advertising_selected_store}
  <BoxCardEntities>
    <!-- en tete -->
    <BoxCardEntitiesHead>
      <Title slot="title-1" title="Modification de" type_title={ETypeTitle.H4} />
      <span slot="title-2" class="md:ml-4">{$advertising_selected_store.title}</span>
      <BtnCloseUpdate
        slot="btn-close-update"
        changeUpdate={closeUpdate}
        relief={true}
        size="w-4 h-4"
      />
    </BoxCardEntitiesHead>

    <!-- partie publicité selectionné -->
    <BoxCardEntitiesBody>
      <form
        on:submit|preventDefault={async (e) =>
          await updateAdvertisingArticleSelected(e, $advertising_selected_store.id)}
      >
        <!-- title -->
        <div>
          <!-- svelte-ignore a11y-label-has-associated-control -->
          <label> Titre de la publicité : </label>
          <Input name="title" placeholder="titre" value={$advertising_selected_store.title} />
        </div>

        <!-- modification ajout d'une image -->
        <section class="flex flex-col items-center justify-center mb-24 mt-12">
          <div class="flex flex-col items-center">
            <!-- si pas d'image on affiche svg de remplacement -->
            {#if $advertising_selected_store.image !== ''}
              <img
                class="w-56 h-44 mt-8 mb-2"
                src={`${$advertising_selected_store.image}`}
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
                on:change={loadImageWebappSelected}
              />
            </div>
          </div>
          <!-- btn envoie ou suppression img -->
          <div class="flex">
            <button
              class={`${loader_sup_img_advertising} btn btn-xs btn-secondary mr-4`}
              on:click={() => deleteImage($advertising_selected_store.id)}>Supprimer l'image</button
            >
            <button
              class={`${loader_img_advertising} btn btn-xs btn-primary`}
              on:click={() => uploadImg($advertising_selected_store.id)}>Envoyer</button
            >
          </div>

          <!-- libellé du label -->
          {#if $advertising_selected_store.label}
            <div>
              <!-- svelte-ignore a11y-label-has-associated-control -->
              <label> label : </label>
              <span class="text-2xs font-bold">libellé</span>
              <Input
                name="libelle"
                placeholder="libelle"
                value={$advertising_selected_store.label.libelle}
              />
              <span class="text-2xs font-bold">déscription</span>
              <Input
                name="description"
                placeholder="description"
                value={$advertising_selected_store.label.description}
              />
            </div>
          {/if}

          <!-- btn modifier condition generale -->
          <BoxCardEntitiesBoxBtnForm>
            <button class={`${loader_save_advertising_article_selected} btn btn-primary mt-12`}
              >Valider</button
            >
          </BoxCardEntitiesBoxBtnForm>
        </section>
      </form>
    </BoxCardEntitiesBody>
  </BoxCardEntities>

  <!-- partie article publicité -->
  <AdvertisingArticleTable />
{:else}
  <SpinnerLittle />
{/if}
