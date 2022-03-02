<script lang="ts">
  import BoxTable from '$lib/modules/components/boxs/box-table.svelte';
  import BoxTitleTab from '$lib/modules/components/boxs/box-title-tab.svelte';
  import BtnAddEntities from '$lib/modules/components/btn/btn-add-entities.svelte';
  import BtnDelete from '$lib/modules/components/btn/btn-delete.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import { advertising_article_store } from '../store/advertising-article.store';
  import { advertising_selected_store } from '../store/advertising-selected.store';
  import { advertising_store } from '../store/advertising.store';
  import AdvertisingSelectedUpdate from './advertising-selected-update.svelte';

  let see_update = false;

  /**
   * retour de fonction du composant
   * advertising-select-update
   * permet de fermer le volet update
   * @param e event click
   */
  function closeUpdate(e) {
    see_update = e.details;
  }

  /**
   * ajouter une publicité
   */
  async function addAdvertising(): Promise<void> {
    await advertising_store.addAdvertissing();
  }

  /**
   * éffacer une publicité
   */
  async function deleteAdvertising(idAdvertising: string): Promise<void> {
    //on ferme le volet update
    see_update = false;
    await advertising_store.deleteAdvertising(idAdvertising);
  }

  /**
   * ecoute la publicité gen selectionné
   */
  function selectedAdvertising(idAdvertising: string): void {
    // ecout du store selectionner
    advertising_selected_store.listenAdvertisingSelected(idAdvertising);

    // on écoute la collection article du document publicité selectionné
    advertising_article_store.listenAdvertisingSelectedArticle(idAdvertising);
    //on ouvre le volet update
    see_update = true;
  }
</script>

<BoxTitleTab>
  <Title title="liste des publicités" type_title={ETypeTitle.H4} />
</BoxTitleTab>

<!-- tableau de publicité -->
<BoxTable>
  <thead>
    <tr>
      <th>id</th>
      <th>Titre</th>
      <th>Actions</th>
    </tr>
  </thead>
  <!-- corps -->
  <tbody>
    {#if $advertising_store}
      <!-- si il y a des entrées on affiche sinon on affiche 0 -->
      {#if $advertising_store.length > 0}
        {#each $advertising_store as advertising (advertising.id)}
          <tr>
            <th>{advertising.id}</th>
            <td>{advertising.title === '' ? 'sans titre' : advertising.title}</td>
            <td class="flex items-center">
              <input
                type="checkbox"
                class="toggle toggle-secondary toggle-xs mx-2"
                checked={advertising.active}
              />
              <BtnUpdate changeUpdate={() => selectedAdvertising(advertising.id)} />
              <BtnDelete changeUpdate={() => deleteAdvertising(advertising.id)} />
            </td>
          </tr>
        {/each}
      {:else}
        <tr> 0 </tr>
      {/if}
    {/if}
  </tbody>
</BoxTable>

<!-- partie boutton ajouter une publicité -->
<BtnAddEntities handlerClick={() => addAdvertising()} />

<!--  -->
{#if see_update}
  <AdvertisingSelectedUpdate on:close_update={closeUpdate} />
{/if}
