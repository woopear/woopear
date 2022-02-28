<script lang="ts">
  import BoxCardEntitiesBody from '$lib/modules/components/boxs/box-card-entities-body.svelte';
  import BoxCardEntitiesBoxBtnForm from '$lib/modules/components/boxs/box-card-entities-box-btn-form.svelte';
  import BoxCardEntitiesHead from '$lib/modules/components/boxs/box-card-entities-head.svelte';
  import BoxCardEntities from '$lib/modules/components/boxs/box-card-entities.svelte';
  import BtnCloseUpdate from '$lib/modules/components/btn/btn-close-update.svelte';
  import Input from '$lib/modules/components/input/input.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import { createObjectAsFormData } from '$lib/providers/format/format.service';
  import { createEventDispatcher } from 'svelte';
  import { team_seletect_store } from '../store/team-selected.store';
  import ProducersTab from './producers-tab.svelte';

  let loader_save_team_selected = '';

  // creation event dispatch
  const dist = createEventDispatcher();

  /**
   * fermeture du volet de modification de la presentation
   */
  function closeUpdate(): void {
    dist('close_update', false);
  }

  /**
   * modification de la team
   * @param e event form
   * @param idTeamSelected id de la team selectionné
   */
  async function updateTeamSelected(e, idTeamSelected: string): Promise<void> {
    const data = createObjectAsFormData(e.target);
    await team_seletect_store.updateTeamSelected(data, idTeamSelected);
  }
</script>

<BoxCardEntities>
  <!-- en-tete -->
  <BoxCardEntitiesHead>
    <Title slot="title-1" title="Modification de" type_title={ETypeTitle.H4} />
    <span slot="title-2" class="md:ml-4">{$team_seletect_store.title}</span>
    <BtnCloseUpdate
      slot="btn-close-update"
      changeUpdate={closeUpdate}
      relief={true}
      size="w-4 h-4"
    />
  </BoxCardEntitiesHead>

  <!-- body card -->
  <BoxCardEntitiesBody>
    <form
      on:submit|preventDefault={async (e) => await updateTeamSelected(e, $team_seletect_store.id)}
    >
      <!-- title -->
      <div>
        <!-- svelte-ignore a11y-label-has-associated-control -->
        <label> Titre de la team : </label>
        <Input name="title" placeholder="titre" value={$team_seletect_store.title} />
      </div>

      <!-- description -->
      <div>
        <!-- svelte-ignore a11y-label-has-associated-control -->
        <label> Description de la team : </label>
        <Input
          name="description"
          placeholder="votre description"
          value={$team_seletect_store.description}
        />
      </div>
      <!-- btn modifier condition generale -->
      <BoxCardEntitiesBoxBtnForm>
        <button class={`${loader_save_team_selected} btn btn-primary mt-12`}>Valider</button>
      </BoxCardEntitiesBoxBtnForm>
    </form>
  </BoxCardEntitiesBody>
</BoxCardEntities>

<!-- tableau des producers -->
<ProducersTab />
