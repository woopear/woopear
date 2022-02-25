<script lang="ts">
  import BoxTable from '$lib/modules/components/boxs/box-table.svelte';
  import BoxTitleTab from '$lib/modules/components/boxs/box-title-tab.svelte';
  import BtnAddEntities from '$lib/modules/components/btn/btn-add-entities.svelte';
  import BtnDelete from '$lib/modules/components/btn/btn-delete.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import { webapps_store } from '../webapp.store';

  let see_update = false;

  /**
   * ajout d'un webapp
   */
  async function addWebapp(): Promise<void> {
    await webapps_store.addWebApp();
  }

  function selectedWebapp(idWebapp: string): void {}

  /**
   * modification de webapp
   * @param e event checkbox
   * @param idWebapp id de la webapp
   */
  async function activeDisableWebapp(e, idWebapp: string): Promise<void> {
    // creation des datas
    const data = { active: e.target.checked };
    // modification
    await webapps_store.updateWebapp(data, idWebapp);
  }

  /**
   * suppression d'un web app
   * @param idWebapp
   */
  async function deleteWebapp(idWebapp: string): Promise<void> {
    await webapps_store.deleteWebapp(idWebapp);
  }
</script>

<BoxTitleTab>
  <Title title="Liste des web app créé par woopear" type_title={ETypeTitle.H4} />
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
  <!-- corps -->
  <tbody>
    {#if $webapps_store}
      <!-- si il y a des entrées on affiche sinon on affiche 0 -->
      {#if $webapps_store.length > 0}
        {#each $webapps_store as webapp (webapp.id)}
          <tr>
            <th>{webapp.id}</th>
            <td>{webapp.title === '' ? 'sans titre' : webapp.title}</td>
            <td class="flex items-center">
              <input
                type="checkbox"
                class="toggle toggle-secondary toggle-xs mx-2"
                checked={webapp.active}
                on:change={(e) => activeDisableWebapp(e, webapp.id)}
              />
              <BtnUpdate changeUpdate={() => selectedWebapp(webapp.id)} />
              <BtnDelete changeUpdate={() => deleteWebapp(webapp.id)} />
            </td>
          </tr>
        {/each}
      {:else}
        <tr> 0 </tr>
      {/if}
    {/if}
  </tbody>
</BoxTable>

<!-- partie btn ajout condition gen -->
<BtnAddEntities handlerClick={() => addWebapp()} />

<!-- update condition gen -->
{#if see_update}
  <p>coucou</p>
{/if}
