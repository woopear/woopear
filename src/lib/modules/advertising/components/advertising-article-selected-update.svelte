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
  import ImgEmptySvg from '$lib/modules/components/img-empty-svg/img-empty-svg.svelte';
  import Input from '$lib/modules/components/input/input.svelte';
  import Texarea from '$lib/modules/components/textarea/texarea.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import Tooltip from '$lib/modules/components/tooltip/tooltip.svelte';

  import { createObjectAsFormData } from '$lib/providers/format/format.service';
  import { createEventDispatcher } from 'svelte';
  import { advertising_article_content_store } from '../store/advertising-article-content.store';
  import { advertising_article_selected_store } from '../store/advertising-article-seleted.store';
  import { advertising_article_store } from '../store/advertising-article.store';
  import { advertising_selected_store } from '../store/advertising-selected.store';

  let loader_save_advert_selected = '';
  let loader_save_content = '';
  let img;
  let loader_img_advertising_article = '';
  let loader_sup_img_advertising_article = '';
  // creation event dispatch
  const dist = createEventDispatcher();

  /**
   * fermeture du volet de modification de la presentation
   */
  function closeUpdate(): void {
    dist('close_update', false);
  }

  /**
   * modification de l'article de la publicité selectionné
   * @param e => event form
   * @param idAdvertisingArticleSelect => id de l'article selectionné
   */
  async function updateAdvertisingArticleSelected(
    e,
    idAdvertisingArticleSelect: string
  ): Promise<void> {
    // creation des données
    const data = createObjectAsFormData(e.target);
    // modification
    await advertising_article_selected_store.updateAdvertisingSelected(
      $advertising_selected_store.id,
      idAdvertisingArticleSelect,
      data
    );
  }

  /**
   * ajoute un contenu à l'article de la publicité selectionné
   * @param idAdvertisingArticleSelect id de la condition gen type selectionné
   */
  async function addContentAdvertisingArticle(idAdvertisingArticleSelect: string): Promise<void> {
    await advertising_article_content_store.addContentAdvertisingArticleSelected(
      $advertising_selected_store.id,
      idAdvertisingArticleSelect
    );
  }

  /**
   * delete un content de l'article de la publicité selectionné
   * @param idAdvertisingArticleSelect id de l'article de la publicité selectionné
   * @param idContent id de l'article de la publicité contents
   */
  async function deleteAdvertisingArticleSelected(
    idAdvertisingArticleSelect: string,
    idContent: string
  ): Promise<void> {
    await advertising_article_content_store.deleteContentArticleAdvertisingSelected(
      $advertising_selected_store.id,
      idAdvertisingArticleSelect,
      idContent
    );
  }

  /**
   * modification des contents de l'article publicité selectionné
   * @param idAdvertisingArticleSelect id de l'article de la publicité selected
   * @param idAdvertisingSelected id de l'article de la publicité selected
   */
  async function updateAllContentConditionGenTypeSelected(
    idAdvertisingArticleSelect: string,
    idAdvertisingSelected: string
  ): Promise<void> {
    await advertising_article_content_store.updateContentAdvertisingArticleSelected(
      idAdvertisingSelected,
      idAdvertisingArticleSelect
    );
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
   * @param idAdvertisingArticleSelected id l'article de la publicité selected
   */
  async function uploadImg(
    idAdvertisingSelected: string,
    idAdvertisingArticleSelected: string
  ): Promise<void> {
    loader_img_advertising_article = 'loading';
    await advertising_article_store.uploadImageAdvertisingArticleSelected(
      img,
      idAdvertisingSelected,
      idAdvertisingArticleSelected
    );
    loader_img_advertising_article = '';
  }

  /**
   * suppression de l'image au web app selected
   * @param idAdvertisingSelected id de la publicité selected
   * @param idAdvertisingArticleSelected id de l'article de la publicité selected
   */
  async function deleteImage(
    idAdvertisingSelected: string,
    idAdvertisingArticleSelected: string
  ): Promise<void> {
    loader_sup_img_advertising_article = 'loading';
    await advertising_article_store.deleteImageAdvertisingArticleSelected(
      idAdvertisingSelected,
      idAdvertisingArticleSelected
    );
    loader_sup_img_advertising_article = '';
  }
</script>

{#if 'id' in $advertising_article_selected_store}
  <BoxCardEntities>
    <!-- en tete -->
    <BoxCardEntitiesHead>
      <Title slot="title-1" title="Modification de" type_title={ETypeTitle.H4} />
      <span slot="title-2" class="md:ml-4">{$advertising_article_selected_store.title}</span>
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
          await updateAdvertisingArticleSelected(e, $advertising_article_selected_store.id)}
      >
        <!-- title -->
        <div>
          <!-- svelte-ignore a11y-label-has-associated-control -->
          <label> Titre de l'article' : </label>
          <Input
            name="title"
            placeholder="titre"
            value={$advertising_article_selected_store.title}
          />
        </div>

        <!-- modification ajout d'une image -->
        <section class="flex flex-col items-center justify-center mb-24 mt-12">
          <div class="flex flex-col items-center">
            <!-- si pas d'image on affiche svg de remplacement -->
            {#if $advertising_article_selected_store.image !== ''}
              <img
                class="w-56 h-44 mt-8 mb-2"
                src={`${$advertising_article_selected_store.image}`}
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
              class={`${loader_sup_img_advertising_article} btn btn-xs btn-secondary mr-4`}
              on:click={() =>
                deleteImage($advertising_selected_store.id, $advertising_article_selected_store.id)}
              >Supprimer l'image</button
            >
            <button
              class={`${loader_img_advertising_article} btn btn-xs btn-primary`}
              on:click={() =>
                uploadImg($advertising_selected_store.id, $advertising_article_selected_store.id)}
              >Envoyer</button
            >
          </div>

          <!-- btn modifier condition generale -->
          <BoxCardEntitiesBoxBtnForm>
            <button class={`${loader_save_advert_selected} btn btn-primary mt-12`}>Valider</button>
          </BoxCardEntitiesBoxBtnForm>
        </section>
      </form>
    </BoxCardEntitiesBody>

    <!-- Partie Content -->
    <!-- en tete -->
    <BoxContentHeader>
      <Title slot="title-content" title="Partie contenu" type_title={ETypeTitle.H6} />
      <!-- btn ajout content -->
      <Tooltip slot="add-content" data="ajouter un contenu">
        <BtnAdd
          changeUpdate={() => addContentAdvertisingArticle($advertising_article_selected_store.id)}
        />
      </Tooltip>
    </BoxContentHeader>

    <!-- form contents -->
    {#each $advertising_article_content_store as content, i (content.id)}
      <BoxContentBody id={content.id}>
        <p slot="title">Document numéro : {content.id}</p>
        <Tooltip slot="btn-delete" data="Supprimer le contenu">
          <BtnDelete
            size="w-5 h-5"
            changeUpdate={() =>
              deleteAdvertisingArticleSelected($advertising_selected_store.id, content.id)}
          />
        </Tooltip>

        <!-- sous title -->
        <div>
          <!-- svelte-ignore a11y-label-has-associated-control -->
          <label> Sous Titre de l'article' : </label>
          <Input name="sub_title" placeholder="sub_title" value={content.sub_title} />
        </div>

        <div slot="input-content">
          <!-- svelte-ignore a11y-label-has-associated-control -->
          <label>Texte du contenu : </label>
          <Texarea
            name="content"
            bind:value={content.text}
            placeholder="Texte de la présentation"
          />
        </div>
      </BoxContentBody>
    {/each}
    <!-- btn modifier content -->
    {#if $advertising_article_content_store.length !== 0}
      <BoxCardEntitiesBoxBtnForm>
        <button
          class={`${loader_save_content} btn btn-primary mt-12`}
          on:click={() =>
            updateAllContentConditionGenTypeSelected(
              $advertising_article_selected_store.id,
              $advertising_selected_store.id
            )}>Enregistrer les contenus</button
        >
      </BoxCardEntitiesBoxBtnForm>
    {/if}
  </BoxCardEntities>
{/if}
