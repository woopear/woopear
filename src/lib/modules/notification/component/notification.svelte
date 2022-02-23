<script lang="ts">
  import { store_notification } from '../store/notification.store';
</script>

{#if $store_notification.length > 0}
  <section class=" rounded-lg fixed top-20 right-8 w-full sm:w-5/12 md:w-4/12 z-50">
    {#each $store_notification as notification}
      {#if notification.type === 'warning'}
        <section class="mt-2 alert shadow-lg bg-opacity-100 alert-warning text-white">
          <div>
            <span>{notification.libelle}</span>
          </div>
        </section>
      {:else if notification.type === 'error'}
        <section class="mt-2 alert shadow-lg bg-opacity-100 alert-error text-white">
          <div>
            <span>{notification.libelle}</span>
          </div>
        </section>
      {:else if notification.type === 'success'}
        <section class="mt-2 alert shadow-lg bg-opacity-100 alert-success text-white">
          <div>
            <span>{notification.libelle}</span>
          </div>
        </section>
      {:else if notification.type === 'info'}
        <section class="mt-2 alert shadow-lg bg-opacity-100 alert-info text-white">
          <div>
            <span>{notification.libelle}</span>
          </div>
        </section>
      {/if}
    {/each}
  </section>
{/if}
