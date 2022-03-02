<script lang="ts">
  import BoxTable from '$lib/modules/components/boxs/box-table.svelte';
  import BoxTitleTab from '$lib/modules/components/boxs/box-title-tab.svelte';
  import BtnAddEntities from '$lib/modules/components/btn/btn-add-entities.svelte';
  import BtnDelete from '$lib/modules/components/btn/btn-delete.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import { team_producer_selected_store } from '../store/producer-selected.store';
  import { team_producers_store } from '../store/producers.store';
  import { team_seletect_store } from '../store/team-selected.store';
  import ProducerSelectedUpdate from './producer-selected-update.svelte';

  let see_update = false;

  /**
   * ferme le volet de modification
   * @param e event du composant enfant
   */
  function closeSeeUpdate(e): void {
    see_update = e.details;
  }

  /**
   * selection du producer
   * @param idTeamProducer id du producer
   */
  function selectedTeamProducer(idTeamProducer: string): void {
    team_producer_selected_store.listenTeamProducerSelected(
      $team_seletect_store.id,
      idTeamProducer
    );
    see_update = true;
  }

  /**
   * delete un producer
   * @param idTeamProducer id de la team producer ciblé
   */
  async function deleteTeamProducer(idTeamProducer: string): Promise<void> {
    await team_producers_store.deleteTeamProducer($team_seletect_store.id, idTeamProducer);
  }

  /**
   * ajout d'un producer
   */
  async function addNewTeamProducer(): Promise<void> {
    await team_producers_store.addTeamProducer($team_seletect_store.id);
  }
</script>

<BoxTitleTab>
  <Title title="Liste des personnes de l'équipe" type_title={ETypeTitle.H4} />
</BoxTitleTab>

<!-- tableau des producers -->
<BoxTable>
  <!-- head -->
  <thead>
    <tr>
      <th>id</th>
      <th>Nom, prénom</th>
      <th>Actions</th>
    </tr>
  </thead>

  <!-- body -->
  <tbody>
    {#if $team_producers_store}
      <!-- si il y a des entrées on affiche sinon on affiche 0 -->
      {#if $team_producers_store.length > 0}
        {#each $team_producers_store as producer (producer.id)}
          <tr>
            <th>{producer.id}</th>
            <td>{producer.full_name === '' ? 'pas encore de nom' : producer.full_name}</td>
            <td class="flex items-center">
              <BtnUpdate changeUpdate={() => selectedTeamProducer(producer.id)} />
              <BtnDelete changeUpdate={() => deleteTeamProducer(producer.id)} />
            </td>
          </tr>
        {/each}
      {:else}
        <tr> 0 </tr>
      {/if}
    {/if}
  </tbody>
</BoxTable>

<!-- btn add teams -->
<BtnAddEntities data="Ajouter une personne" handlerClick={addNewTeamProducer} />

<!-- producer selectionné -->
{#if see_update}
  <ProducerSelectedUpdate on:close_update={closeSeeUpdate} />
{/if}
