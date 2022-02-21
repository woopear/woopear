<script lang="ts">
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
  import { presentation_selected_store, presentation_store } from '../presentation.store';
  import type { IPresentation } from '../presentation.type';
  import { fade } from 'svelte/transition';

  const dist = createEventDispatcher();

  const closeUpdate = () => {
    dist('close_update', false);
    presentation_selected_store.set({} as IPresentation);
  };

  const updatePresentation = async (e, id: string) => {
    const data = createObjectAsFormData<IPresentation>(e.target);
    console.log(data);
  };

  const updateContent = (e) => {
    console.log('coucou update content');
  };

  const addContentPresentation = async (idPresentation: string) => {
    await presentation_store.createContentPresentation(idPresentation);
    presentation_selected_store.set($presentation_store.find((el) => el.id === idPresentation));
  };

  const deleteContentPresentation = async (idPresentation, idContent) => {
    await presentation_store.deleteContentPresentation(idPresentation, idContent);
    presentation_selected_store.set($presentation_store.find((el) => el.id === idPresentation));
  };
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
    <form on:submit|preventDefault={updateContent}>
      {#each $presentation_selected_store.contents as content, index}
        {#key $presentation_selected_store.contents}
          <section transition:fade class="mb-12">
            <p class="font-light mb-4 flex items-center">
              Contenu du document <span class="font-bold ml-4">{content.id}</span>
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
              <label>Content sous titre {index} : </label>
              <Input name="sub_title" value={content.sub_title} placeholder="Un sous titre" />
            </div>
            <div>
              <label>Texte du contenu {index} : </label>
              <Texarea name="text" value={content.text} placeholder="Texte de la présentation" />
            </div>
          </section>
        {/key}
      {/each}
      <!-- btn modifier content -->
      <div class="flex justify-end">
        <button class="btn btn-primary mt-12">Enregistrer</button>
      </div>
    </form>
  </section>
</section>

<style>
  form > div {
    margin-top: 15px;
  }
</style>
