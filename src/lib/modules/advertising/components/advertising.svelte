<script lang="ts">
  import BoxTable from '$lib/modules/components/boxs/box-table.svelte';
  import BoxTitleTab from '$lib/modules/components/boxs/box-title-tab.svelte';
  import BtnAddEntities from '$lib/modules/components/btn/btn-add-entities.svelte';
  import BtnDelete from '$lib/modules/components/btn/btn-delete.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import { advertising_store } from '../store/advertising.store';
  import AdvertisingSelectedUpdate from './advertising-selected-update.svelte';

  let see_update = false;

  /**
   * ajouter une publicité
   */
  async function addAdvertising(): Promise<void> {
    await advertising_store.addAdvertissing();
  }

  /**
   * affacer une publicité
   */
  async function deleteAdvertising(idAdvertising): Promise<void> {
    await advertising_store.deleteAdvertising(idAdvertising);
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
            <BtnUpdate changeUpdate={''} />
            <BtnDelete changeUpdate={() => deleteAdvertising(advertising.id)} />
          </td>
        </tr>
      {/each}
    {/if}
  {/if}
</BoxTable>

<!-- partie boutton ajouter une publicité -->
<BtnAddEntities handlerClick={() => addAdvertising()} />

<!--  -->
{#if see_update}
  <AdvertisingSelectedUpdate />
{/if}
