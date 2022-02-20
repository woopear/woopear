<script lang="ts">
  import { beforeUpdate } from 'svelte';
  import { presentation_store } from '../presentation.store';

  beforeUpdate(() => {
    console.log($presentation_store);
  });
</script>

<section class="overflow-x-auto">
  <table class="table w-full">
    <!-- head -->
    <thead>
      <tr>
        <th>id</th>
        <th>Titre</th>
        <th>Nb contents</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      {#if $presentation_store}
        {#if $presentation_store.length > 0}
          {#each $presentation_store as presentation}
            <tr>
              <th>{presentation.id}</th>
              <td>{presentation.title}</td>
              <td>{presentation.contents.length}</td>
              <td>btns action</td>
            </tr>
          {/each}
        {/if}
      {/if}
    </tbody>
  </table>
</section>
