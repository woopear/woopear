<script lang="ts">
  import BtnCloseUpdate from '$lib/modules/components/btn/btn-close-update.svelte';
  import Input from '$lib/modules/components/input/input.svelte';
  import Texarea from '$lib/modules/components/textarea/texarea.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import type { IPresentation } from '../presentation.type';

  export let presentation_selected: IPresentation;
  export let closeUpdate;
</script>

<section class="mt-16 card bg-base-200 px-6 py-8 md:px-12">
  <!-- en-tete -->
  <section class="card-title flex items-start md:items-center justify-between">
    <div class="md:flex md:items-end">
      <Title title="Modification de" type_title={ETypeTitle.H4} />
      <span class="md:ml-4">{presentation_selected.id}</span>
    </div>
    <BtnCloseUpdate changeUpdate={closeUpdate} relief={true} size="w-4 h-4" />
  </section>

  <!-- corps -->
  <section class="mt-8">
    <!-- form info principal -->
    <form>
      <!-- title -->
      <div>
        <label>Titre de la présentation : </label>
        <Input name="title" placeholder="titre" value={presentation_selected.title} />
      </div>
      <!-- sub_title -->
      <div>
        <label>Sous-titre de la présentation : </label>
        <Input name="sub_title" placeholder="sous titre" value={presentation_selected.sub_title} />
      </div>

      <!-- WOOPEAR -->
      <span class=" block mt-12 mb-4">
        <Title title="Partie entreprise" type_title={ETypeTitle.H6} />
      </span>
      <!-- email -->
      <div>
        <label>E-mail de l'entreprise : </label>
        <Input
          name="email"
          placeholder="E-mail de l'entreprise"
          value={presentation_selected.woopear.email}
        />
      </div>
      <!-- phone_number -->
      <div>
        <label>Numero de téléphone : </label>
        <Input
          name="phone_number"
          placeholder="Numero de téléphone"
          value={presentation_selected.woopear.phone_number}
        />
      </div>
      <!-- name -->
      <div>
        <label>Le nom de l'entreprise : </label>
        <Input
          name="name"
          placeholder="le nom de l'entreprise à présenter"
          value={presentation_selected.woopear.name}
        />
      </div>
      <!-- address -->
      <div>
        <label>L'addresse de l'entreprise : </label>
        <Input
          name="address"
          placeholder="L'addresse de l'entreprise"
          value={presentation_selected.woopear.address}
        />
      </div>
      <!-- code_post -->
      <div>
        <label>Code postal de l'entreprise : </label>
        <Input
          name="code_post"
          placeholder="Code postal"
          value={presentation_selected.woopear.code_post}
        />
      </div>
      <!-- city -->
      <div>
        <label>Ville de l'entreprise : </label>
        <Input
          name="city"
          placeholder="Ville de l'entreprise"
          value={presentation_selected.woopear.city}
        />
      </div>
      <!-- map -->
      <div>
        <label>Coordonnées : </label>
        <Input name="map" placeholder="Coordonnée" value={presentation_selected.woopear.map} />
      </div>
      <!-- info -->
      <div>
        <label>Info suplémentaire : </label>
        <Texarea name="info" value={presentation_selected.woopear.info} />
      </div>
      <!-- btn modifier info pincipal -->
      <div class="flex justify-end">
        <button class="btn btn-primary mt-12">Modifier</button>
      </div>
    </form>

    <!-- form content -->
  </section>
</section>

<style>
  form > div {
    margin-top: 15px;
  }
</style>
