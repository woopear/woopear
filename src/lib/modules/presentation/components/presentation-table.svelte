<script lang="ts">
  import { presentation_store } from '../presentation.store';
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
    <!-- corps -->
    <tbody>
      {#if $presentation_store}
        <!-- si il y a des entrées on affiche sinon on affiche 0 -->
        {#if $presentation_store.length > 0}
          {#each $presentation_store as presentation}
            <tr>
              <th>{presentation.id}</th>
              <td>{presentation.title}</td>
              <td>{presentation.contents ? presentation.contents.length : ''}</td>
              <td>btns action</td>
            </tr>
          {/each}
        {:else}
          <tr> 0 </tr>
        {/if}
      {/if}
    </tbody>
  </table>
</section>
