<script lang="ts">
  import BoxTable from '$lib/modules/components/boxs/box-table.svelte';
  import BoxTitleTab from '$lib/modules/components/boxs/box-title-tab.svelte';
  import BtnAddEntities from '$lib/modules/components/btn/btn-add-entities.svelte';
  import BtnDelete from '$lib/modules/components/btn/btn-delete.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import { team_producers_store } from '../store/producers.store';
  import { team_seletect_store } from '../store/team-selected.store';
  import { teams_store } from '../store/teams.store';
  import TeamSelectedUpdate from './team-selected-update.svelte';

  let see_update = false;

  /**
   * ferme le volet de modification
   * @param e event component teamSelectedUpdate
   */
  function closeUpdate(e): void {
    see_update = e.details;
  }

  /**
   * active desactive team
   * @param e event checkbox
   * @param idTeam id de la team ciblé
   */
  async function activeDisableTeam(e, idTeam: string): Promise<void> {
    await teams_store.updateTeam({ active: e.target.checked }, idTeam);
  }

  /**
   * selection d'une team pour modification
   * @param idTeam
   */
  function selectedTeam(idTeam: string): void {
    team_seletect_store.listenTeamSelected(idTeam);
    team_producers_store.listenTeamProducers(idTeam);
    see_update = true;
  }

  /**
   * suppression team
   * @param idTeam id de la team ciblé
   */
  async function deleteTeam(idTeam: string): Promise<void> {
    await teams_store.deleteTeam(idTeam);
  }

  /**
   * ajoute une team
   */
  async function addNewTeam(): Promise<void> {
    await teams_store.addTeam();
  }
</script>

<BoxTitleTab>
  <Title title="Liste des équipes" type_title={ETypeTitle.H4} />
</BoxTitleTab>

<BoxTable>
  <!-- head -->
  <thead>
    <tr>
      <th>id</th>
      <th>Titre</th>
      <th>Actions</th>
    </tr>
  </thead>
  <!-- body -->
  <tbody>
    {#if $teams_store}
      <!-- si il y a des entrées on affiche sinon on affiche 0 -->
      {#if $teams_store.length > 0}
        {#each $teams_store as team (team.id)}
          <tr>
            <th>{team.id}</th>
            <td>{team.title === '' ? 'sans titre' : team.title}</td>
            <td class="flex items-center">
              <input
                type="checkbox"
                class="toggle toggle-secondary toggle-xs mx-2"
                checked={team.active}
                on:change={(e) => activeDisableTeam(e, team.id)}
              />
              <BtnUpdate changeUpdate={() => selectedTeam(team.id)} />
              <BtnDelete changeUpdate={() => deleteTeam(team.id)} />
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
<BtnAddEntities data="Ajouter une équipe" handlerClick={addNewTeam} />

<!-- team selectionné -->
{#if see_update}
  <TeamSelectedUpdate on:close_update={closeUpdate} />
{/if}
