<script lang="ts">
  import BtnCloseUpdate from '$lib/modules/components/btn/btn-close-update.svelte';
  import Input from '$lib/modules/components/input/input.svelte';
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
      <!-- email -->
      <div>
        <label>E-mail de l'entreprise : </label>
        <Input name="email" placeholder="email" value={presentation_selected.woopear.email} />
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

      <div class="flex justify-end">
        <button class="btn btn-primary mt-12">Modifier</button>
      </div>
    </form>
  </section>
</section>

<style>
  form > div {
    margin-top: 15px;
  }
</style>
