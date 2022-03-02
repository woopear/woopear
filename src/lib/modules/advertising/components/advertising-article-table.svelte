<script lang="ts">
  import BoxTable from '$lib/modules/components/boxs/box-table.svelte';
  import BoxTitleTab from '$lib/modules/components/boxs/box-title-tab.svelte';
  import BtnAddEntities from '$lib/modules/components/btn/btn-add-entities.svelte';
  import BtnDelete from '$lib/modules/components/btn/btn-delete.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import { advertising_article_content_store } from '../store/advertising-article-content.store';
  import { advertising_article_selected_store } from '../store/advertising-article-seleted.store';
  import { advertising_article_store } from '../store/advertising-article.store';
  import { advertising_selected_store } from '../store/advertising-selected.store';
  import AdvertisingArticleSelectedUpdate from './advertising-article-selected-update.svelte';

  let see_update = false;

  /**
   * retour de fonction du composant
   * condition-gen-select-update
   * permet de fermer le volet update
   * @param e event click
   */
  function closeUpdate(e) {
    see_update = e.details;
  }

  async function addArticleAdvertising(): Promise<void> {
    await advertising_article_store.addArticleAdvertisingSelected($advertising_selected_store.id);
  }

  async function deleteArticleAdvertising(idAdvertisingArticle: string): Promise<void> {
    await advertising_article_store.deleteArticleAdvertisingSelected(
      $advertising_selected_store.id,
      idAdvertisingArticle
    );
  }

  function selectedArticleAdvertising(idAdvertisingArticle: string): void {
    // ecoute de la publicité selectionné
    advertising_article_selected_store.listenAdvertisingSelected(
      $advertising_selected_store.id,
      idAdvertisingArticle
    );
    // ecoute des contents de l'article de la publicité selectionné
    advertising_article_content_store.listenAdvertisingArticleContent(
      $advertising_selected_store.id,
      idAdvertisingArticle
    );

    //on ouvre le volet update
    see_update = true;
  }
</script>

<!-- global table -->
<BoxTitleTab>
  <Title
    title={`Liste des articles de ${$advertising_selected_store.title}`}
    type_title={ETypeTitle.H4}
  />
</BoxTitleTab>

<!-- tableau -->
<BoxTable>
  <!-- head -->
  <thead>
    <tr>
      <th>id</th>
      <th>Titre</th>
      <th>Article</th>
      <th>Actions</th>
    </tr>
  </thead>
  <!-- corps -->
  <tbody>
    {#if $advertising_selected_store}
      <!-- si il y a des entrées on affiche sinon on affiche 0 -->
      {#if $advertising_article_store.length > 0}
        {#each $advertising_article_store as advertising (advertising.id)}
          <tr>
            <th>{advertising.id}</th>
            <td>{advertising.title === '' ? 'sans titre' : advertising.title}</td>
            <td class="flex items-center">
              <BtnUpdate changeUpdate={() => selectedArticleAdvertising(advertising.id)} />
              <BtnDelete changeUpdate={() => deleteArticleAdvertising(advertising.id)} />
            </td>
          </tr>
        {/each}
      {:else}
        <tr> 0 </tr>
      {/if}
    {/if}
  </tbody>
</BoxTable>

<!-- partie btn ajout condition gen type -->
<BtnAddEntities handlerClick={() => addArticleAdvertising()} />

<!-- update condition gen type -->
{#if see_update}
  <AdvertisingArticleSelectedUpdate on:close_update={closeUpdate} />
{/if}
