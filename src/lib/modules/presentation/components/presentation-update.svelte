<script lang="ts">
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
  import { presentation_selected_store, presentation_store } from '../presentation.store';
  import type { IPresentation } from '../presentation.type';

  // pour le loader des btn
  let loader_img_avatar = '';

  // stocke file img
  let img_file;

  const dist = createEventDispatcher();

  /**
   * fermeture du volet de modification de la presentation
   */
  const closeUpdate = () => {
    dist('close_update', false);
    presentation_selected_store.set({} as IPresentation);
  };

  /**
   * modification des données racine d'une présentation
   * @param e => event form
   * @param id => id de la presentation ciblé
   */
  const updatePresentation = async (e, id: string) => {
    // formatage des données
    const data = createObjectAsFormData<IPresentation>(e.target);
    // modification
    await presentation_store.updatePresentation(id, data);
  };

  /**
   * modification du contenu des contents
   * @param idPresentation id de la presentation selectionné
   */
  const updateAllContent = async (idPresentation: string) => {
    // modification
    await presentation_store.updateContentOfPresentation(idPresentation);
  };

  /**
   * ajout de content de la presentation selected
   * @param idPresentation id de la présentation
   */
  const addContentPresentation = async (idPresentation: string) => {
    // creation d'un content à la presentation selectionné
    await presentation_store.createContentPresentation(idPresentation);
  };

  /**
   * suppression d'un content de la presentation selected
   * @param idPresentation id de la présentation
   * @param idContent id du content
   */
  const deleteContentPresentation = async (idPresentation: string, idContent: string) => {
    await presentation_store.deleteContentPresentation(idPresentation, idContent);
  };

  /**
   * recuperation du fichier
   * @param e => envent onChange
   */
  function loadImagePresentation(e) {
    img_file = e.target.files[0];
  }

  /**
   * upload img presentation selectionné
   * @param idPresentation
   */
  async function uploadImg(idPresentation: string) {
    loader_img_avatar = 'loading';
    // si img file est renseigné sinon error
    if (img_file) {
      await presentation_store.uploadImagePresentation(img_file, idPresentation);
    } else {
      // TODO : gerer erreur si fichier pas charger
    }
    loader_img_avatar = '';
  }

  /**
   * supprime l'image de la presentation
   * @param idPresentation id de la presentation selectionné
   */
  async function deleteImage(idPresentation: string): Promise<void> {
    await presentation_store.deleteImagePresentation(idPresentation);
  }
</script>

<section class="mt-16 card bg-base-200 px-6 py-8 md:px-12">
  <!-- en-tete -->
  <section class="card-title flex items-start md:items-center justify-between">
    <div class="md:flex md:items-end">
      <Title title="Modification de" type_title={ETypeTitle.H4} />
      <span class="md:ml-4">{$presentation_selected_store.id}</span>
    </div>
    <BtnCloseUpdate changeUpdate={closeUpdate} relief={true} size="w-4 h-4" />
  </section>

  <!-- corps -->
  <section class="mt-8">
    <!-- section image -->
    <section class="flex flex-col items-center justify-center mb-24 mt-2">
      <div class="flex flex-col items-center">
        <!-- si pas d'image on affiche svg de remplacement -->
        {#if $presentation_selected_store.image !== ''}
          <img
            class="w-20 h-20 rounded-full mt-8 mb-2"
            src={`${$presentation_selected_store.image}`}
            alt="profil user"
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
            on:change={loadImagePresentation}
          />
        </div>
      </div>
      <!-- btn envoie ou suppression img -->
      <div class="flex">
        <button
          class={`${loader_img_avatar} btn btn-xs btn-secondary mr-4`}
          on:click={() => deleteImage($presentation_selected_store.id)}>Supprimer l'image</button
        >
        <button
          class={`${loader_img_avatar} btn btn-xs btn-primary`}
          on:click={() => uploadImg($presentation_selected_store.id)}>Envoyer</button
        >
      </div>
    </section>

    <!-- form info principal -->
    <form on:submit|preventDefault={(e) => updatePresentation(e, $presentation_selected_store.id)}>
      <!-- title -->
      <div>
        <label>Titre de la présentation : </label>
        <Input name="title" placeholder="titre" value={$presentation_selected_store.title} />
      </div>
      <!-- sub_title -->
      <div>
        <label>Sous-titre de la présentation : </label>
        <Input
          name="sub_title"
          placeholder="sous titre"
          value={$presentation_selected_store.sub_title}
        />
      </div>

      <!-- WOOPEAR -->
      <span class=" block mt-12 mb-4">
        <Title title="Partie entreprise" type_title={ETypeTitle.H6} />
      </span>
      <!-- email -->
      <div>
        <label>E-mail de l'entreprise : </label>
        <Input
          name="woopear.email"
          placeholder="E-mail de l'entreprise"
          value={$presentation_selected_store.woopear.email}
        />
      </div>
      <!-- phone_number -->
      <div>
        <label>Numero de téléphone : </label>
        <Input
          name="woopear.phone_number"
          placeholder="Numero de téléphone"
          value={$presentation_selected_store.woopear.phone_number}
        />
      </div>
      <!-- name -->
      <div>
        <label>Le nom de l'entreprise : </label>
        <Input
          name="woopear.name"
          placeholder="le nom de l'entreprise à présenter"
          value={$presentation_selected_store.woopear.name}
        />
      </div>
      <!-- address -->
      <div>
        <label>L'addresse de l'entreprise : </label>
        <Input
          name="woopear.address"
          placeholder="L'addresse de l'entreprise"
          value={$presentation_selected_store.woopear.address}
        />
      </div>
      <!-- code_post -->
      <div>
        <label>Code postal de l'entreprise : </label>
        <Input
          name="woopear.code_post"
          placeholder="Code postal"
          value={$presentation_selected_store.woopear.code_post}
        />
      </div>
      <!-- city -->
      <div>
        <label>Ville de l'entreprise : </label>
        <Input
          name="woopear.city"
          placeholder="Ville de l'entreprise"
          value={$presentation_selected_store.woopear.city}
        />
      </div>
      <!-- map -->
      <div>
        <label>Coordonnées : </label>
        <Input
          name="woopear.map"
          placeholder="Coordonnée"
          value={$presentation_selected_store.woopear.map}
        />
      </div>
      <!-- info -->
      <div>
        <label>Info suplémentaire : </label>
        <Texarea name="woopear.info" value={$presentation_selected_store.woopear.info} />
      </div>
      <!-- btn modifier info pincipal -->
      <div class="flex justify-end">
        <button class="btn btn-primary mt-12">Modifier</button>
      </div>
    </form>

    <!-- Partie Content -->
    <span class="flex mt-16 mb-8">
      <div class="mr-6">
        <Title title="Partie contenu" type_title={ETypeTitle.H6} />
      </div>
      <!-- btn ajout content -->
      <Tooltip data="ajouter un contenu">
        <BtnAdd changeUpdate={() => addContentPresentation($presentation_selected_store.id)} />
      </Tooltip>
    </span>
    <!-- form content -->
    <div>
      {#each $presentation_selected_store.contents as content, i (content.id)}
        <section class="mb-12">
          <p class="font-light mb-4 flex items-center">
            Document numéro : {content.id}
            <span class="ml-4">
              <Tooltip data="Supprimer le contenu">
                <BtnDelete
                  size="w-5 h-5"
                  changeUpdate={() =>
                    deleteContentPresentation($presentation_selected_store.id, content.id)}
                />
              </Tooltip>
            </span>
          </p>
          <div class="mb-4">
            <label>Sous titre : </label>
            <Input name="sub_title" bind:value={content.sub_title} placeholder="Un sous titre" />
          </div>
          <div>
            <label>Texte du contenu : </label>
            <Texarea name="text" bind:value={content.text} placeholder="Texte de la présentation" />
          </div>
        </section>
      {/each}
      <!-- btn modifier content -->
      {#if $presentation_selected_store.contents.length !== 0}
        <div class="flex justify-end">
          <button
            class="btn btn-primary mt-12"
            on:click={() => updateAllContent($presentation_selected_store.id)}
            >Enregistrer le contenu</button
          >
        </div>
      {/if}
    </div>
  </section>
</section>

<style>
  form > div {
    margin-top: 15px;
  }

  label {
    font-weight: 700;
  }
</style>
